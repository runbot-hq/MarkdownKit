// MarkdownRenderLog.swift
// MarkdownKit
import OSLog

/// Internal diagnostics for the MarkdownKit rendering pipeline.
///
/// Uses a package-owned subsystem so MarkdownKit does not depend on a
/// consuming application's logging namespace.
enum MarkdownRenderLog {
    /// Shared `os_log` logger scoped to `MarkdownRender` category.
    static let logger = Logger(
        subsystem: "io.github.markdownkit",
        category: "MarkdownRender"
    )

    /// Emits a debug-level log event (verbose; filtered in production).
    static func debug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }

    /// Emits a notice-level log event (always visible in Console.app).
    static func notice(_ message: String) {
        logger.notice("\(message, privacy: .public)")
    }

    /// Emits an error-level log event.
    static func error(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }
}

// MARK: - Diagnostic kind helpers

extension MarkdownBlock {
    /// Short stable string identifying the block kind — safe to log (no content).
    public var renderLogKind: String {
        switch self {
        case .heading(let level, _): return "heading-\(level)"
        case .paragraph:             return "paragraph"
        case .orderedList:           return "ordered-list"
        case .unorderedList:         return "unordered-list"
        case .blockQuote:            return "blockquote"
        case .codeBlock:             return "code-block"
        case .thematicBreak:         return "thematic-break"
        case .table:                 return "table"
        case .unknown:               return "unknown"
        }
    }
}

extension InlineNode {
    /// Short stable string identifying the inline kind — safe to log (no content).
    public var renderLogKind: String {
        switch self {
        case .text:          return "text"
        case .softBreak:     return "soft-break"
        case .lineBreak:     return "line-break"
        case .code:          return "inline-code"
        case .strong:        return "strong"
        case .emphasis:      return "emphasis"
        case .strikethrough: return "strikethrough"
        case .link:          return "link"
        case .unknown:       return "unknown"
        }
    }
}

