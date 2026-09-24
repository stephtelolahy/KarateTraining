//
//  KataEditing.swift
//  KataKit — creating and editing kata sequences
//

import Foundation
#if canImport(Combine)
import Combine
#endif

// MARK: - Mutating API on Kata

public extension Kata {

    /// Re-applies 1-based numbering after any structural change.
    mutating func renumber() {
        for index in movements.indices {
            movements[index].number = index + 1
        }
    }

    private mutating func touch() {
        updatedAt = Date()
        revision += 1
    }

    @discardableResult
    mutating func append(_ movement: Movement) -> Movement {
        var new = movement
        new.number = movements.count + 1
        movements.append(new)
        touch()
        return new
    }

    mutating func insert(_ movement: Movement, at index: Int) {
        let clamped = min(max(index, 0), movements.count)
        movements.insert(movement, at: clamped)
        renumber()
        touch()
    }

    mutating func remove(at index: Int) {
        guard movements.indices.contains(index) else { return }
        movements.remove(at: index)
        renumber()
        touch()
    }

    mutating func remove(id: UUID) {
        guard let index = movements.firstIndex(where: { $0.id == id }) else { return }
        remove(at: index)
    }

    mutating func move(from source: Int, to destination: Int) {
        guard movements.indices.contains(source) else { return }
        let movement = movements.remove(at: source)
        let clamped = min(max(destination, 0), movements.count)
        movements.insert(movement, at: clamped)
        renumber()
        touch()
    }

    mutating func duplicate(at index: Int) {
        guard movements.indices.contains(index) else { return }
        var copy = movements[index]
        copy.id = UUID()
        insert(copy, at: index + 1)
    }

    mutating func update(_ movement: Movement) {
        guard let index = movements.firstIndex(where: { $0.id == movement.id }) else { return }
        movements[index] = movement
        touch()
    }

    /// Replaces the sequence by its left/right mirror image — a classic drill and
    /// a fast way to author a symmetric variant.
    mutating func mirror() {
        movements = movements.map(\.mirrored)
        renumber()
        touch()
    }

    /// Adds a technique to a given movement, applying default level and weapon.
    mutating func addTechnique(_ technique: Technique, toMovementWithID id: UUID) {
        guard let index = movements.firstIndex(where: { $0.id == id }) else { return }
        movements[index].techniques.append(technique)
        touch()
    }

    mutating func setKiai(at numbers: [Int]) {
        for index in movements.indices {
            movements[index].hasKiai = numbers.contains(movements[index].number)
        }
        touch()
    }
}

// MARK: - Mutating API on KataSeries

public extension KataSeries {
    mutating func append(_ kata: Kata) {
        self.kata.append(kata)
        updatedAt = Date()
    }

    mutating func remove(kataID: UUID) {
        kata.removeAll { $0.id == kataID }
        updatedAt = Date()
    }

    mutating func move(from source: Int, to destination: Int) {
        guard kata.indices.contains(source) else { return }
        let item = kata.remove(at: source)
        kata.insert(item, at: min(max(destination, 0), kata.count))
        updatedAt = Date()
    }
}

// MARK: - Validation

public enum IssueSeverity: String, Codable, CaseIterable {
    case info, warning, error
}

public struct KataIssue: Identifiable, Codable, Hashable {
    public var id = UUID()
    public var severity: IssueSeverity
    public var message: String
    /// Movement the issue relates to, when applicable.
    public var movementNumber: Int?

    public init(severity: IssueSeverity, message: String, movementNumber: Int? = nil) {
        self.severity = severity
        self.message = message
        self.movementNumber = movementNumber
    }
}

public enum KataValidator {

    public static func validate(_ kata: Kata) -> [KataIssue] {
        var issues: [KataIssue] = []

        if kata.name.trimmingCharacters(in: .whitespaces).isEmpty {
            issues.append(.init(severity: .error, message: "The kata has no name."))
        }

        if kata.movements.isEmpty {
            issues.append(.init(severity: .error, message: "The kata contains no movement."))
            return issues
        }

        if let expected = kata.officialMovementCount, expected != kata.movementCount {
            issues.append(.init(
                severity: .warning,
                message: "\(kata.movementCount) movements entered, the official count is \(expected)."
            ))
        }

        if kata.kiaiPoints.isEmpty {
            issues.append(.init(severity: .warning, message: "No kiai defined; most kata have two."))
        } else if kata.kiaiPoints.count > 3 {
            issues.append(.init(
                severity: .info,
                message: "\(kata.kiaiPoints.count) kiai defined, which is unusual."
            ))
        }

        let numbers = kata.movements.map(\.number)
        if Set(numbers).count != numbers.count {
            issues.append(.init(severity: .error, message: "Duplicate movement numbers; call renumber()."))
        }

        for movement in kata.movements {
            if movement.techniques.isEmpty {
                issues.append(.init(
                    severity: .warning,
                    message: "Movement \(movement.displayCount) has no technique.",
                    movementNumber: movement.number
                ))
            }

            for technique in movement.techniques
            where technique.level == nil && technique.kind.category != .kamae {
                issues.append(.init(
                    severity: .info,
                    message: "\(technique.kind.romaji) has no level set.",
                    movementNumber: movement.number
                ))
            }

            if movement.transition.rotationDegrees != 0 && movement.transition.rotation == .none {
                issues.append(.init(
                    severity: .warning,
                    message: "A rotation of \(movement.transition.rotationDegrees)° has no direction.",
                    movementNumber: movement.number
                ))
            }

            if movement.stance.isOneLegged && movement.techniques.contains(where: {
                if case .kick = $0.kind { return true } else { return false }
            }) == false && movement.transition.step == .none {
                issues.append(.init(
                    severity: .info,
                    message: "One-legged stance without a kick — check the posture.",
                    movementNumber: movement.number
                ))
            }
        }

        // Embusen continuity: each facing should be reachable from the previous one
        // through the declared rotation.
        for (previous, current) in zip(kata.movements, kata.movements.dropFirst()) {
            let signedRotation = current.transition.rotation == .counterClockwise
                ? -current.transition.rotationDegrees
                : current.transition.rotationDegrees
            let expected = Facing(degrees: previous.facing.degrees + signedRotation)
            if expected != current.facing {
                issues.append(.init(
                    severity: .warning,
                    message: "Facing \(current.facing.english) is inconsistent with the declared rotation "
                        + "(expected \(expected.english)).",
                    movementNumber: current.number
                ))
            }
        }

        return issues
    }

    public static func isPublishable(_ kata: Kata) -> Bool {
        validate(kata).allSatisfy { $0.severity != .error }
    }
}

// MARK: - Editor (undo / redo)

#if canImport(Combine)
/// Observable editing session, ready to drive a SwiftUI editor screen.
@available(iOS 13.0, macOS 10.15, *)
public final class KataEditor: ObservableObject {

    @Published public private(set) var kata: Kata
    @Published public private(set) var issues: [KataIssue] = []
    @Published public var selectedMovementID: UUID?

    private var undoStack: [Kata] = []
    private var redoStack: [Kata] = []
    private let stackLimit = 50

    public init(kata: Kata) {
        self.kata = kata
        self.issues = KataValidator.validate(kata)
    }

    public var canUndo: Bool { !undoStack.isEmpty }
    public var canRedo: Bool { !redoStack.isEmpty }

    /// Every mutation goes through this so undo/redo and validation stay coherent.
    public func perform(_ change: (inout Kata) -> Void) {
        undoStack.append(kata)
        if undoStack.count > stackLimit { undoStack.removeFirst() }
        redoStack.removeAll()
        change(&kata)
        revalidate()
    }

    public func undo() {
        guard let previous = undoStack.popLast() else { return }
        redoStack.append(kata)
        kata = previous
        revalidate()
    }

    public func redo() {
        guard let next = redoStack.popLast() else { return }
        undoStack.append(kata)
        kata = next
        revalidate()
    }

    private func revalidate() { issues = KataValidator.validate(kata) }

    // Common commands -----------------------------------------------------

    public func addMovement(_ movement: Movement) {
        perform { $0.append(movement) }
    }

    public func insertMovement(_ movement: Movement, at index: Int) {
        perform { $0.insert(movement, at: index) }
    }

    public func deleteSelected() {
        guard let id = selectedMovementID else { return }
        perform { $0.remove(id: id) }
        selectedMovementID = nil
    }

    public func moveMovement(from source: Int, to destination: Int) {
        perform { $0.move(from: source, to: destination) }
    }

    public func update(_ movement: Movement) {
        perform { $0.update(movement) }
    }

    public func mirrorKata() {
        perform { $0.mirror() }
    }
}
#endif

// MARK: - Persistence helpers

public enum KataStore {
    public static func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    public static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    public static func data(from series: KataSeries) throws -> Data {
        try encoder().encode(series)
    }

    public static func series(from data: Data) throws -> KataSeries {
        try decoder().decode(KataSeries.self, from: data)
    }

    public static func save(_ series: KataSeries, to url: URL) throws {
        try data(from: series).write(to: url, options: .atomic)
    }

    public static func load(from url: URL) throws -> KataSeries {
        try series(from: Data(contentsOf: url))
    }
}

// MARK: - Textual export (for printing a sheet or sharing)

public extension Kata {
    /// Markdown listing of the whole sequence.
    func markdownSheet() -> String {
        var lines: [String] = []
        lines.append("# \(name)\(kanji.map { " \($0)" } ?? "")")
        if let meaning { lines.append("_\(meaning)_") }
        lines.append("")
        lines.append("- Group: \(group.english)")
        lines.append("- Embusen: \(embusen.english)")
        if let rank = requiredRank { lines.append("- Grade: \(rank.english) (\(rank.beltColorName) belt)") }
        lines.append("- Movements: \(movementCount)"
            + (officialMovementCount.map { " / \($0) official" } ?? ""))
        lines.append("- Kiai: \(kiaiPoints.map(String.init).joined(separator: ", "))")
        lines.append("")
        lines.append("| # | Technique(s) | Stance | Facing | Transition | Notes |")
        lines.append("|---|---|---|---|---|---|")
        for movement in movements {
            let techniques = movement.techniques.map(\.label).joined(separator: " + ")
            let notes = [movement.hasKiai ? "KIAI" : nil, movement.notes]
                .compactMap { $0 }
                .joined(separator: " — ")
            lines.append("| \(movement.displayCount) | \(techniques) | \(movement.stance.romaji) "
                + "| \(movement.facing.english) | \(movement.transition.summary) | \(notes) |")
        }
        return lines.joined(separator: "\n")
    }
}
