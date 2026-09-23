import SwiftUI

struct TechniqueDetailView: View {
    let techniqueID: TechniqueID

    private var technique: Technique { techniqueID.definition }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text(technique.romaji).font(.largeTitle.bold())
                    Text(technique.french).foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)

                LabeledContent("Catégorie") {
                    Label(technique.category.title, systemImage: technique.category.symbol)
                }
                LabeledContent("Famille") { Text(technique.category.japanese) }
                LabeledContent("Identifiant") {
                    Text(technique.id.rawValue).font(.callout.monospaced())
                }
            }

            if let description = technique.description {
                Section("Description") { Text(description) }
            }
        }
        .navigationTitle(technique.romaji)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TechniqueDetailView(techniqueID: .oiZuki)
}
