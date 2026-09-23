import Foundation
import Observation

/// Charge et valide le contenu pédagogique depuis `training.json`.
@Observable
final class ContentStore {
    private(set) var programs: [TrainingProgram] = []
    /// Message d'erreur lisible si le JSON est absent, invalide ou incohérent.
    private(set) var loadError: String?

    init(bundle: Bundle = .main, resource: String = "training") {
        do {
            guard let url = bundle.url(forResource: resource, withExtension: "json") else {
                throw ContentError.fileNotFound("\(resource).json")
            }
            let data = try Data(contentsOf: url)
            let content = try JSONDecoder().decode(TrainingContent.self, from: data)
            let issues = content.validationIssues()
            guard issues.isEmpty else { throw ContentError.invalid(issues) }
            programs = content.programs
        } catch {
            loadError = Self.describe(error)
        }
    }

    // MARK: Erreurs

    private static func describe(_ error: Error) -> String {
        if let error = error as? ContentError { return error.errorDescription ?? "Erreur de contenu" }
        guard let decoding = error as? DecodingError else { return error.localizedDescription }

        func path(_ context: DecodingError.Context) -> String {
            context.codingPath
                .map { $0.intValue.map(String.init) ?? $0.stringValue }
                .joined(separator: " › ")
        }
        switch decoding {
        case .dataCorrupted(let c):
            return "Données corrompues (\(path(c))) : \(c.debugDescription)"
        case .keyNotFound(let key, let c):
            return "Clé manquante « \(key.stringValue) » (\(path(c)))"
        case .typeMismatch(_, let c), .valueNotFound(_, let c):
            return "Valeur invalide (\(path(c))) : \(c.debugDescription)"
        @unknown default:
            return decoding.localizedDescription
        }
    }
}

enum ContentError: LocalizedError {
    case fileNotFound(String)
    case invalid([String])

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            "Fichier \(name) introuvable dans l'application."
        case .invalid(let issues):
            "Contenu incohérent :\n" + issues.map { "• \($0)" }.joined(separator: "\n")
        }
    }
}

private extension TrainingContent {
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

private extension Exercise {
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
        case .kumite:
            if !steps.contains(where: { $0.role == .attack }) { issues.append("attaque manquante") }
            if !steps.contains(where: { $0.role == .defense }) { issues.append("défense manquante") }
        }
        return issues
    }
}
