import Foundation

// MARK: - Programme

struct TrainingContent: Decodable {
    let version: Int
    let programs: [TrainingProgram]
}

struct TrainingProgram: Identifiable, Decodable, Hashable {
    let id: String
    let title: String
    let summary: String
    /// Séquence ordonnée d'exercices.
    let exercises: [Exercise]
}

// MARK: - Exercice

struct Exercise: Identifiable, Decodable, Hashable {
    let id: String
    let type: ExerciseType
    /// Titre libre ; sinon généré à partir des techniques.
    var title: String?
    var direction: Direction = .onSpot
    var repetitions: Int = 1
    var notes: String?
    var steps: [Step] = []
}

// MARK: - Étape

/// Une technique d'un exercice, avec son rôle explicite.
struct Step: Decodable, Hashable {
    let role: StepRole
    let technique: TechniqueID
    /// Niveau visé (jodan / chudan / gedan).
    var target: TargetLevel?
    /// Position (dachi) adoptée pour cette étape — de départ pour une parade
    /// ou un coup de poing, d'arrivée pour un coup de pied.
    var stance: TechniqueID?
}


/// Type d'exercice.
enum ExerciseType: String, Codable, CaseIterable, Identifiable, Hashable {
    case technique     // technique individuelle (éventuellement dans une position)
    case combo         // combinaison de plusieurs techniques
    case kata
    case kumite        // combat à un pas : attaque / défense / contre-attaque

    var id: String { rawValue }

    var title: String {
        switch self {
        case .technique:   "Technique"
        case .combo:       "Combinaison"
        case .kata:        "Kata"
        case .kumite:      "Kumite"
        }
    }

    var symbol: String {
        switch self {
        case .technique:   "scope"
        case .combo:       "link"
        case .kata:        "figure.martial.arts"
        case .kumite:      "person.2.fill"
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
