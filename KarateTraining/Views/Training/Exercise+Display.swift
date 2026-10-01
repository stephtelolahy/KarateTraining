import Foundation

extension Step {
    /// Ex. « Oi-zuki jodan » ou « Mae-geri chudan (sur place) ».
    var label: String {
        var text = techniques.map(\.definition.romaji).joined(separator: " + ")
        if let target { text += " \(target.rawValue)" }
        return text
    }

    /// Côté et niveau, ex. « Hidari Chudan », « Migi » (sans niveau)
    /// ou « Chudan (milieu) » (sans côté).
    var levelText: String? {
        switch (side, target) {
        case let (side?, target?): "\(side.title) \(target.rawValue.capitalized)"
        case let (side?, nil):     side.title
        case let (nil, target?):   target.title
        case (nil, nil):           nil
        }
    }
}

extension Exercise {
    /// Titre lisible, ex. « Zenkutsu-dachi + Age-uke + Gyaku-zuki »
    /// ou « Oi-zuki jodan / Age-uke + Gyaku-zuki » pour un ippon kumite.
    var displayTitle: String {
        if let title, !title.isEmpty { return title }

        switch type {
        case .kata:
            return title ?? "Kata"

        case .kumite:
            let attack = Self.segments(for: steps.filter { $0.role == .attack })
            let response = Self.segments(for: steps.filter { $0.role != .attack })
            return attack.joined(separator: " + ") + " / " + response.joined(separator: " + ")

        case .technique, .combo:
            let body = Self.segments(for: steps).joined(separator: " + ")
            return body
        }
    }

    /// Une position précède sa technique, sauf pour un coup de pied
    /// (on retombe dans la position après la frappe).
    private static func segments(for steps: [Step]) -> [String] {
        steps.map(\.label)
    }
}
