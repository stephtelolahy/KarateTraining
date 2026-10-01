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
                    Text(technique.category.title)
                }

                if let imageURL = technique.imageURL,
                    let url = URL(string: imageURL) {
                    LabeledContent("Image") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 160)
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
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

