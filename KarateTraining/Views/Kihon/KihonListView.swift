import SwiftUI

/// Onglet Kihon : catalogue des techniques et des katas, avec recherche
/// (techniques, katas et exercices).
struct KihonListView: View {
    @Environment(ContentStore.self) private var store
    @State private var search = ""
    @State private var scope: SearchScope = .all

    enum SearchScope: String, CaseIterable, Identifiable {
        case all, techniques, katas

        var id: String { rawValue }

        var title: String {
            switch self {
            case .all:        "Tout"
            case .techniques: "Techniques"
            case .katas:      "Katas"
            }
        }
    }

    /// Un exercice avec le programme (niveau) auquel il appartient.
    private struct ExerciseHit: Identifiable {
        let exercise: Exercise
        let program: TrainingProgram
        var id: String { exercise.id }
    }

    private struct CategorySection: Identifiable {
        let category: TechniqueCategory
        let techniques: [Technique]
        var id: TechniqueCategory { category }
    }

    // MARK: Résultats

    /// Exercices de tous les programmes, dédupliqués par identifiant.
    private var allExercises: [ExerciseHit] {
        var seen = Set<String>()
        return store.programs.flatMap { program in
            program.exercises.map { ExerciseHit(exercise: $0, program: program) }
        }
        .filter { seen.insert($0.id).inserted }
    }

    private var katas: [ExerciseHit] {
        guard scope != .techniques else { return [] }
        return allExercises.filter { $0.exercise.type == .kata && $0.exercise.matches(search) }
    }

    /// Combinaisons et kumite, uniquement pendant une recherche « Tout ».
    private var exercises: [ExerciseHit] {
        guard scope == .all, !search.searchNormalized.isEmpty else { return [] }
        return allExercises.filter {
            [.combo, .kumite].contains($0.exercise.type) && $0.exercise.matches(search)
        }
    }

    private var techniqueSections: [CategorySection] {
        guard scope != .katas else { return [] }
        return TechniqueCategory.allCases.compactMap { category in
            let items = TechniqueCatalog.techniques(in: category).filter { $0.matches(search) }
            return items.isEmpty ? nil : CategorySection(category: category, techniques: items)
        }
    }

    private var isEmpty: Bool {
        katas.isEmpty && exercises.isEmpty && techniqueSections.isEmpty
    }

    // MARK: Vue

    var body: some View {
        NavigationStack {
            List {
                results
            }
            .overlay {
                if isEmpty { ContentUnavailableView.search(text: search) }
            }
            .navigationTitle("Kihon")
            .searchable(
                text: $search,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Techniques, katas, exercices"
            )
            .searchScopes($scope) {
                ForEach(SearchScope.allCases) { Text($0.title).tag($0) }
            }
            .autocorrectionDisabled(true)
            .techniqueDestination()
            .navigationDestination(for: Exercise.self) { ExerciseDetailView(exercise: $0) }
        }
    }

    @ViewBuilder
    private var results: some View {
        if !katas.isEmpty {
            Section("Katas") {
                ForEach(katas) { exerciseLink($0) }
            }
        }
        ForEach(techniqueSections) { section in
            Section {
                ForEach(section.techniques) { technique in
                    NavigationLink(value: technique.id) {
                        TechniqueRow(technique: technique)
                    }
                }
            } header: {
                Label(section.category.title, systemImage: section.category.symbol)
            }
        }
        if !exercises.isEmpty {
            Section("Exercices") {
                ForEach(exercises) { exerciseLink($0) }
            }
        }
    }

    private func exerciseLink(_ hit: ExerciseHit) -> some View {
        NavigationLink(value: hit.exercise) {
            HStack(spacing: 12) {
                Image(systemName: hit.exercise.type.symbol)
                    .foregroundStyle(hit.exercise.type.tint)
                    .frame(width: 26)
                VStack(alignment: .leading, spacing: 2) {
                    Text(hit.exercise.displayTitle).font(.headline)
                    Text(hit.program.title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 2)
        }
    }
}

struct TechniqueRow: View {
    let technique: Technique

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(technique.romaji).font(.headline)
            Text(technique.french)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    KihonListView().environment(ContentStore())
}
