import Foundation

/// Type d'exercice.
enum ExerciseType: String, Codable, CaseIterable, Identifiable, Hashable {
    case technique     // technique individuelle (éventuellement dans une position)
    case combo         // combinaison de plusieurs techniques
    case ipponKumite   // combat à un pas : attaque / défense / contre-attaque
    case kata

    var id: String { rawValue }

    var title: String {
        switch self {
        case .technique:   "Technique"
        case .combo:       "Combinaison"
        case .ipponKumite: "Ippon Kumite"
        case .kata:        "Kata"
        }
    }

    var symbol: String {
        switch self {
        case .technique:   "scope"
        case .combo:       "link"
        case .ipponKumite: "person.2.fill"
        case .kata:        "figure.martial.arts"
        }
    }
}

/// Direction de l'exercice (→, ←, ↔ ou sur place).
enum Direction: String, Codable, CaseIterable, Hashable {
    case forward          // →
    case backward         // ←
    case forwardAndBack   // ↔
    case onSpot           // sans déplacement

    var symbol: String {
        switch self {
        case .forward:        "→"
        case .backward:       "←"
        case .forwardAndBack: "↔"
        case .onSpot:         "•"
        }
    }

    var title: String {
        switch self {
        case .forward:        "Avant"
        case .backward:       "Arrière"
        case .forwardAndBack: "Aller-retour"
        case .onSpot:         "Sur place"
        }
    }
}

/// Niveau visé par une technique.
enum TargetLevel: String, Codable, CaseIterable, Hashable {
    case jodan, chudan, gedan

    var title: String {
        switch self {
        case .jodan:  "Jodan (haut)"
        case .chudan: "Chudan (milieu)"
        case .gedan:  "Gedan (bas)"
        }
    }
}

/// Rôle d'une étape : attaque, défense ou contre-attaque.
/// En ippon kumite, l'attaque est faite par l'attaquant ; défense et
/// contre-attaque par le défenseur.
enum StepRole: String, Codable, CaseIterable, Hashable {
    case attack
    case defense
    case counterAttack

    var title: String {
        switch self {
        case .attack:        "Attaque"
        case .defense:       "Défense"
        case .counterAttack: "Contre-attaque"
        }
    }

    var symbol: String {
        switch self {
        case .attack:        "bolt.fill"
        case .defense:       "shield.fill"
        case .counterAttack: "arrow.uturn.left.circle.fill"
        }
    }
}
