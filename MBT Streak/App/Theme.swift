import SwiftUI

enum Theme {
    static let mostBlue = Color(red: 7 / 255, green: 72 / 255, blue: 127 / 255)
    static let flameOrange = Color(red: 255 / 255, green: 63 / 255, blue: 31 / 255)
    static let cleanWhite = Color.white
    static let aqua = Color(red: 49 / 255, green: 215 / 255, blue: 255 / 255)
    static let ink = Color(red: 9 / 255, green: 23 / 255, blue: 37 / 255)
    static let softBlue = Color(red: 231 / 255, green: 245 / 255, blue: 252 / 255)
    static let line = Color(red: 216 / 255, green: 229 / 255, blue: 238 / 255)
}

extension LinearGradient {
    static var streakHeader: LinearGradient {
        LinearGradient(
            colors: [Theme.mostBlue, Color(red: 5 / 255, green: 38 / 255, blue: 72 / 255)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
