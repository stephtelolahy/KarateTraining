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
    var notes: String?
    var direction: Direction
    var repetitions: Int
    var steps: [Step]
    var kata: KataID? // TODO: remove

    private enum CodingKeys: String, CodingKey {
        case id, type, title, direction, repetitions, startPosition, stance, steps, kata, notes
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id            = try c.decode(String.self, forKey: .id)
        type          = try c.decode(ExerciseType.self, forKey: .type)
        title         = try c.decodeIfPresent(String.self, forKey: .title)
        direction     = try c.decodeIfPresent(Direction.self, forKey: .direction) ?? .onSpot
        repetitions   = try c.decodeIfPresent(Int.self, forKey: .repetitions) ?? 1
        steps         = try c.decodeIfPresent([Step].self, forKey: .steps) ?? []
        kata          = try c.decodeIfPresent(KataID.self, forKey: .kata)
        notes         = try c.decodeIfPresent(String.self, forKey: .notes)
    }
}

// MARK: - Étape

/// Une technique d'un exercice, avec son rôle explicite.
struct Step: Decodable, Hashable {
    let role: StepRole
    let technique: TechniqueID // TODO: array of techniques
    var target: TargetLevel?
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
        case .kumite:      "Kumite"
        case .kata:        "Kata"
        }
    }

    var symbol: String {
        switch self {
        case .technique:   "scope"
        case .combo:       "link"
        case .kumite: "person.2.fill"
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
