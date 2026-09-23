import SwiftUI

// MARK: - Couleurs par type / rôle

extension ExerciseType {
    var tint: Color {
        switch self {
        case .technique:   .blue
        case .combo:       .purple
        case .kumite: .red
        case .kata:        .green
        }
    }
}

extension StepRole {
    var tint: Color {
        switch self {
        case .attack:        .red
        case .defense:       .blue
        case .counterAttack: .orange
        }
    }
}

// MARK: - Composants

struct Chip: View {
    let text: String
    var systemImage: String? = nil
    var tint: Color = .secondary

    var body: some View {
        HStack(spacing: 4) {
            if let systemImage { Image(systemName: systemImage) }
            Text(text)
        }
        .font(.caption.weight(.medium))
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(tint.opacity(0.15), in: Capsule())
        .foregroundStyle(tint)
    }
}

struct TypeBadge: View {
    let type: ExerciseType
    var body: some View {
        Chip(text: type.title, systemImage: type.symbol, tint: type.tint)
    }
}

struct RoleTag: View {
    let role: StepRole
    var body: some View {
        Chip(text: role.title, systemImage: role.symbol, tint: role.tint)
    }
}

struct InfoTile: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

extension View {
    /// Permet de naviguer vers la fiche d'une technique depuis n'importe quel écran.
    func techniqueDestination() -> some View {
        navigationDestination(for: TechniqueID.self) { TechniqueDetailView(techniqueID: $0) }
    }
}
