//
//  AppLogger.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import Foundation
import os

enum AppLogger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "clothes_shop"

    private static let productLogger = Logger(subsystem: subsystem, category: "Product")
    private static let networkLogger = Logger(subsystem: subsystem, category: "Network")
    private static let uiLogger = Logger(subsystem: subsystem, category: "UI")

    static func product(_ message: String, type: OSLogType = .default) {
        productLogger.log(level: type, "\(message)")
    }

    static func network(_ message: String, type: OSLogType = .default) {
        networkLogger.log(level: type, "\(message)")
    }

    static func ui(_ message: String, type: OSLogType = .default) {
        uiLogger.log(level: type, "\(message)")
    }

    static func error(_ message: String) {
        productLogger.error("❌ \(message)")
    }

    static func debug(_ message: String) {
        productLogger.debug("🐛 \(message)")
    }
}
