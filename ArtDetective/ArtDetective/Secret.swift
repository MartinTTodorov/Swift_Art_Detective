//
//  Secret.swift
//  ArtDetective
//
//  Created by Martin Todorov on 21/05/2023.
//

import Foundation

enum Secret {
    static let yourOpenAIAPIKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
}
