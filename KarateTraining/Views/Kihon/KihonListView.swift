import SwiftUI

struct KihonListView: View {
    @State private var selectedTechniqueID: TechniqueID?

    private struct CategorySection: Identifiable {
        let category: TechniqueCategory
        let techniques: [Technique]
        var id: TechniqueCategory { category }
    }

    private var sections: [CategorySection] {
        TechniqueCategory.allCases.compactMap { category in
            let items = TechniqueCatalog.techniques(in: category)
            return items.isEmpty ? nil : CategorySection(category: category, techniques: items)
        }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTechniqueID) {
                ForEach(sections) { section in
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
            }
            .navigationTitle("Kihon")
        } detail: {
            if let selectedTechniqueID {
                TechniqueDetailView(techniqueID: selectedTechniqueID)
            } else {
                ContentUnavailableView("Sélectionnez une technique", systemImage: "figure.martial.arts")
            }
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
    KihonListView()
}
