import SwiftUI

struct AlertsView: View {
    @EnvironmentObject private var store: StreakStore
    @State private var isCreatingAlert = false

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 16) {
                        AlertSetupPanel {
                            isCreatingAlert = true
                        }
                        FavoritesStrip()
                        FavoriteManagerPanel()
                        SectionTitle("Active rules", action: "\(store.alerts.filter(\.isEnabled).count) on")
                        ForEach(store.alerts) { alert in
                            AlertRow(alert: alert)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Alerts")
            .sheet(isPresented: $isCreatingAlert) {
                CreateAlertView()
                    .environmentObject(store)
            }
        }
    }
}

struct AlertSetupPanel: View {
    let onCreate: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "bell.badge.fill")
                    .foregroundStyle(Theme.flameOrange)
                Text("Personal streak alerts")
                    .font(.headline.bold())
                Spacer()
            }
            Text("Track runs before they become obvious: unbeaten streaks, scoring streaks, clean sheets and form drops.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Button {
                onCreate()
            } label: {
                Label("Create alert", systemImage: "plus")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Theme.mostBlue, in: RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(Theme.cleanWhite)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct CreateAlertView: View {
    @EnvironmentObject private var store: StreakStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTeamID: Team.ID = DemoStreakData.forms[0].team.id
    @State private var selectedPreset = "Alert when unbeaten run reaches 5"
    @State private var customTrigger = ""

    private let presets = [
        "Alert when unbeaten run reaches 5",
        "Alert if scoring streak breaks",
        "Alert after 3 wins in a row",
        "Alert after another clean win",
        "Alert if team concedes first",
        "Alert when live momentum flips"
    ]

    var body: some View {
        NavigationStack {
            AppBackground {
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 12) {
                            SectionTitle("New alert")
                            Picker("Team", selection: $selectedTeamID) {
                                ForEach(store.filteredForms) { form in
                                    Text("\(form.team.shortName) - \(form.team.name)").tag(form.team.id)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(12)
                            .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))

                            Picker("Rule", selection: $selectedPreset) {
                                ForEach(presets, id: \.self) { preset in
                                    Text(preset).tag(preset)
                                }
                            }
                            .pickerStyle(.inline)
                            .padding(12)
                            .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))

                            TextField("Custom alert text", text: $customTrigger, axis: .vertical)
                                .lineLimit(2...4)
                                .padding(12)
                                .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
                        }

                        Button {
                            createAlert()
                        } label: {
                            Label("Save alert", systemImage: "bell.badge.fill")
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Theme.mostBlue, in: RoundedRectangle(cornerRadius: 8))
                                .foregroundStyle(Theme.cleanWhite)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Create alert")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                selectedTeamID = store.filteredForms.first?.team.id ?? selectedTeamID
            }
        }
    }

    private func createAlert() {
        guard let form = store.filteredForms.first(where: { $0.team.id == selectedTeamID }) else { return }
        let trigger = customTrigger.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? selectedPreset : customTrigger
        store.addAlert(team: form.team, trigger: trigger)
        dismiss()
    }
}

struct FavoriteManagerPanel: View {
    @EnvironmentObject private var store: StreakStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Add favorites", action: store.selectedSport.rawValue)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(store.filteredForms) { form in
                    Button {
                        store.toggleFavorite(form.team)
                    } label: {
                        HStack(spacing: 8) {
                            TeamMark(team: form.team, size: 30)
                            Text(form.team.shortName)
                                .font(.caption.bold())
                                .foregroundStyle(Theme.ink)
                            Spacer()
                            Image(systemName: store.isFavorite(form.team) ? "star.fill" : "star")
                                .foregroundStyle(store.isFavorite(form.team) ? Theme.flameOrange : .secondary)
                        }
                        .padding(10)
                        .background(Theme.softBlue, in: RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(16)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct AlertRow: View {
    @EnvironmentObject private var store: StreakStore
    let alert: StreakAlert

    var body: some View {
        HStack(spacing: 12) {
            TeamMark(team: alert.team, size: 48)
            VStack(alignment: .leading, spacing: 5) {
                Text(alert.team.name)
                    .font(.subheadline.bold())
                    .foregroundStyle(Theme.ink)
                    .lineLimit(1)
                Text(alert.trigger)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            FavoriteStarButton(team: alert.team)
            Toggle("", isOn: Binding(
                get: { alert.isEnabled },
                set: { _ in store.toggleAlert(alert) }
            ))
            .labelsHidden()
            .tint(Theme.flameOrange)
        }
        .padding(14)
        .background(Theme.cleanWhite, in: RoundedRectangle(cornerRadius: 8))
    }
}
