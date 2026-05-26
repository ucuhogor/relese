import Foundation

public struct AnalyticsConfiguration: Equatable, Sendable {
    public let serverDomain: String
    public let initialURL: URL
    public let analyticsCheckURL: URL
    public let analyticsToken: String
    public let bundleID: String
    public let initialCheckDelay: TimeInterval
    public let requestTimeout: TimeInterval
    public let requestMode: AnalyticsRequestMode

    public init(
        serverDomain: String? = nil,
        initialURL: URL,
        analyticsCheckURL: URL,
        analyticsToken: String,
        bundleID: String,
        initialCheckDelay: TimeInterval = 0.45,
        requestTimeout: TimeInterval = 7,
        requestMode: AnalyticsRequestMode = .bundleProbe
    ) {
        self.serverDomain = serverDomain ?? analyticsCheckURL.host ?? initialURL.host ?? ""
        self.initialURL = initialURL
        self.analyticsCheckURL = analyticsCheckURL
        self.analyticsToken = analyticsToken
        self.bundleID = bundleID
        self.initialCheckDelay = initialCheckDelay
        self.requestTimeout = requestTimeout
        self.requestMode = requestMode
    }

    public init(
        serverDomain: String,
        analyticsToken: String,
        bundleID: String,
        fallbackURL: URL? = nil,
        initialCheckDelay: TimeInterval = 0.45,
        requestTimeout: TimeInterval = 7,
        requestMode: AnalyticsRequestMode = .bundleProbe
    ) {
        let normalizedDomain = serverDomain.trimmingCharacters(in: .whitespacesAndNewlines)
        let baseURL = URL(string: "https://\(normalizedDomain)")!

        self.init(
            serverDomain: normalizedDomain,
            initialURL: fallbackURL ?? baseURL,
            analyticsCheckURL: URL(string: "https://\(normalizedDomain)/api/v1/check")!,
            analyticsToken: analyticsToken,
            bundleID: bundleID,
            initialCheckDelay: initialCheckDelay,
            requestTimeout: requestTimeout,
            requestMode: requestMode
        )
    }

    public static let standardPreset = AnalyticsConfiguration(
        serverDomain: "aviatoinrush.live",
        analyticsToken: "8504abe7349f9a2423193188abc6047814617a5c07b847df1671c74a913e97cc",
        bundleID: "com.example.analyticskit"
    )

    public func resolvedDestination(_ url: URL) -> AnalyticsConfiguration {
        AnalyticsConfiguration(
            serverDomain: serverDomain,
            initialURL: url,
            analyticsCheckURL: analyticsCheckURL,
            analyticsToken: analyticsToken,
            bundleID: bundleID,
            initialCheckDelay: initialCheckDelay,
            requestTimeout: requestTimeout,
            requestMode: requestMode
        )
    }
}

public enum AnalyticsRequestMode: Equatable, Sendable {
    case bundleProbe
    case launchAnalytics
}
