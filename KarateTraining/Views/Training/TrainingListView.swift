import SwiftUI

struct TrainingListView: View {
    @Environment(ContentStore.self) private var store

    var body: some View {
        NavigationStack {
            Group {
                if let error = store.loadError {
                    ContentUnavailableView {
                        Label("Contenu indisponible", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(error)
                    }
                } else {
                    List {
                        ForEach(store.programs) { program in
                            NavigationLink(value: program) { ProgramRow(program: program) }
                        }
                    }
                }
            }
            .navigationTitle("Training")
            .navigationDestination(for: TrainingProgram.self) { ProgramDetailView(program: $0) }
            .techniqueDestination()
        }
    }
}

struct ProgramRow: View {
    let program: TrainingProgram

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(program.title).font(.headline)
            HStack(spacing: 6) {
                Text("\(program.exercises.count) exercices")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                ForEach(ExerciseType.allCases) { type in
                    let count = program.exercises.filter { $0.type == type }.count
                    if count > 0 {
                        Chip(text: "\(count)", systemImage: type.symbol, tint: type.tint)
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    TrainingListView()
        .environment(ContentStore())
}
