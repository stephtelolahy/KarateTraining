import SwiftUI

// MARK: - Ligne de liste

struct ExerciseRow: View {
    let index: Int
    let exercise: Exercise

    private var movementText: String {
        exercise.repetitions > 1
            ? "\(exercise.direction.symbol) ×\(exercise.repetitions)"
            : exercise.direction.symbol
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(index)")
                .font(.caption.bold().monospacedDigit())
                .foregroundStyle(exercise.type.tint)
                .frame(width: 26, height: 26)
                .background(exercise.type.tint.opacity(0.15), in: Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(exercise.displayTitle)
                HStack(spacing: 6) {
                    TypeBadge(type: exercise.type)
                    if exercise.type != .kata { Chip(text: movementText) }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Écran de détail

struct ExerciseDetailView: View {
    let exercise: Exercise

    var body: some View {
        ScrollView {
            ExerciseContent(exercise: exercise).padding()
        }
        .navigationTitle("Exercice")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Contenu complet d'un exercice (détail + mode entraînement)

struct ExerciseContent: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                TypeBadge(type: exercise.type)
                Text(exercise.displayTitle).font(.title2.bold())
            }

            if exercise.type != .kata { parameters }

            sequence

            if let notes = exercise.notes {
                Text(notes).font(.callout).foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var parameters: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 10)], spacing: 10) {
            InfoTile(title: "Direction",
                     value: "\(exercise.direction.symbol) \(exercise.direction.title)")
            InfoTile(title: "Répétitions", value: "×\(exercise.repetitions)")
        }
    }

    @ViewBuilder
    private var sequence: some View {
        switch exercise.type {
        case .kata:
            if let kata = exercise.kata { KataCard(kata: kata) }

        case .ipponKumite:
            StepSection(title: "Attaquant",
                        steps: exercise.steps.filter { $0.role == .attack })
            StepSection(title: "Défenseur",
                        steps: exercise.steps.filter { $0.role != .attack })

        case .technique, .combo:
            StepSection(title: "Séquence",
                        steps: exercise.steps)
        }
    }
}

// MARK: - Sous-vues

struct StepSection: View {
    let title: String
    let steps: [Step]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.headline)
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                StepCard(number: index + 1, step: step)
            }
        }
    }
}

struct StepCard: View {
    let number: Int
    let step: Step

    private var technique: Technique { step.technique.definition }
    private var stance: TechniqueID? { step.stance }
    private var isKick: Bool { technique.category == .geri }

    /// Un coup de pied se termine dans une position ; une parade ou un coup de poing s'y exécute.
    private func stanceText(for stance: TechniqueID) -> String {
        let name = stance.definition.romaji
        return (isKick && step.stance != nil) ? "Retombe en " + name : name
    }

    var body: some View {
        NavigationLink(value: step.technique) {
            HStack(alignment: .top, spacing: 12) {
                Text("\(number)")
                    .font(.caption.bold().monospacedDigit())
                    .foregroundStyle(step.role.tint)
                    .frame(width: 26, height: 26)
                    .background(step.role.tint.opacity(0.15), in: Circle())

                VStack(alignment: .leading, spacing: 5) {
                    RoleTag(role: step.role)
                    Text(technique.romaji).font(.headline).foregroundStyle(.primary)
                    Text(technique.french).font(.subheadline).foregroundStyle(.secondary)

                    HStack(spacing: 6) {
                        if let target = step.target {
                            Chip(text: target.title, systemImage: "scope")
                        }
                        if let stance {
                            Chip(text: stanceText(for: stance), systemImage: "figure.stand")
                        }
                        if let movement = step.movement {
                            Chip(text: movement.title, systemImage: "arrow.left.and.right")
                        }
                    }
                    if let note = step.note {
                        Text(note).font(.caption).foregroundStyle(.secondary)
                    }
                }
                Spacer(minLength: 0)
                Image(systemName: "chevron.right")
                    .font(.footnote.bold())
                    .foregroundStyle(.tertiary)
            }
            .padding(12)
            .background(Color(.secondarySystemBackground),
                        in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct KataCard: View {
    let kata: KataID

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(kata.name).font(.title3.bold())
            Text(kata.meaning).font(.subheadline).foregroundStyle(.secondary)
            Label("\(kata.moveCount) mouvements", systemImage: "figure.martial.arts")
                .font(.subheadline)
            Text(kata.summary).font(.callout)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
