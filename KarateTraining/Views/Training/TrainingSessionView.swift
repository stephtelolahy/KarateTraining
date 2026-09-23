import SwiftUI

/// Mode entraînement : parcourt les exercices dans l'ordre, un par écran.
struct TrainingSessionView: View {
    let program: TrainingProgram
    @Environment(\.dismiss) private var dismiss
    @State private var index = 0

    private var count: Int { program.exercises.count }
    private var isLast: Bool { index >= count - 1 }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ProgressView(value: Double(index + 1), total: Double(max(count, 1)))
                    .padding(.horizontal)
                    .padding(.top, 8)

                TabView(selection: $index) {
                    ForEach(Array(program.exercises.enumerated()), id: \.element.id) { i, exercise in
                        ScrollView {
                            ExerciseContent(exercise: exercise).padding()
                        }
                        .tag(i)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("\(index + 1) / \(count)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                controls
            }
            .techniqueDestination()
        }
    }

    private var controls: some View {
        HStack {
            Button {
                withAnimation { index -= 1 }
            } label: {
                Label("Précédent", systemImage: "chevron.left")
            }
            .buttonStyle(.bordered)
            .disabled(index == 0)

            Spacer()

            Button {
                if isLast { dismiss() } else { withAnimation { index += 1 } }
            } label: {
                Label(
                    isLast ? "Terminer" : "Suivant",
                    systemImage: isLast ? "checkmark" : "chevron.right"
                )
            }
            .buttonStyle(.glassProminent)
        }
        .padding()
    }
}
