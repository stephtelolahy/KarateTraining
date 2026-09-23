import SwiftUI

struct ProgramDetailView: View {
    @Environment(ContentStore.self) private var store
    let program: TrainingProgram
    @State private var showSession = false

    var body: some View {
        List {
            Section {
                Text(program.summary).foregroundStyle(.secondary)
            }

            Section {
                Button {
                    showSession = true
                } label: {
                    Label("Démarrer l'entraînement", systemImage: "play.fill")
                        .font(.headline)
                }
            }

            Section("Exercices (\(program.exercises.count))") {
                ForEach(Array(program.exercises.enumerated()), id: \.element.id) { index, exercise in
                    NavigationLink(value: exercise) {
                        ExerciseRow(index: index + 1, exercise: exercise)
                    }
                }
            }
        }
        .navigationTitle(program.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Exercise.self) { ExerciseDetailView(exercise: $0) }
        .fullScreenCover(isPresented: $showSession) {
            TrainingSessionView(program: program)
        }
    }
}
