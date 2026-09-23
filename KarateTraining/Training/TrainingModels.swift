import Foundation

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
    /// Mouvement propre à cette étape s'il diffère de celui de l'exercice
    /// (ex. contre-attaque « sur place »).
    var movement: Direction?
    var note: String?
}

// MARK: - Exercice

struct Exercise: Identifiable, Decodable, Hashable {
    let id: String
    let type: ExerciseType
    /// Titre libre ; sinon généré à partir des techniques.
    var title: String?
    var direction: Direction
    var repetitions: Int
    /// Séquence ordonnée. Vide pour un kata.
    var steps: [Step]
    var kata: KataID?
    var notes: String?

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

// MARK: - Programme et niveau

struct TrainingProgram: Identifiable, Decodable, Hashable {
    let id: String
    let title: String
    let summary: String
    /// Séquence ordonnée d'exercices.
    let exercises: [Exercise]
}

struct TrainingContent: Decodable {
    let version: Int
    let programs: [TrainingProgram]
}


// MARK: - Validation

extension TrainingContent {
    /// Retourne la liste des incohérences de contenu (vide si tout va bien).
    func validationIssues() -> [String] {
        var issues: [String] = []
        var seen = Set<String>()
        for program in programs {
            for exercise in program.exercises {
                let context = "\(program.id) › \(exercise.id)"
                if !seen.insert(exercise.id).inserted {
                    issues.append("\(context) : identifiant d'exercice dupliqué")
                }
                issues += exercise.validationIssues().map { "\(context) : \($0)" }
            }
        }
        return issues
    }
}

extension Exercise {
    func validationIssues() -> [String] {
        var issues: [String] = []

        if repetitions < 1 { issues.append("nombre de répétitions invalide") }

        for step in steps {
            if let stance = step.stance, stance.definition.category != .dachi {
                issues.append("« \(stance.rawValue) » n'est pas une position (dachi)")
            }
        }

        switch type {
        case .kata:
            if kata == nil { issues.append("champ « kata » manquant") }
        case .technique:
            if steps.count > 1 { issues.append("une technique individuelle ne contient qu'une étape") }
        case .combo:
            if steps.count < 2 { issues.append("une combinaison contient au moins 2 étapes") }
        case .ipponKumite:
            if !steps.contains(where: { $0.role == .attack }) { issues.append("attaque manquante") }
            if !steps.contains(where: { $0.role == .defense }) { issues.append("défense manquante") }
        }
        return issues
    }
}
