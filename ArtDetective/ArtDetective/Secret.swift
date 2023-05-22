//
//  Secret.swift
//  ArtDetective
//
//  Created by Radolina on 22/05/2023.
//

import Foundation

enum Secret {
    static let yourOpenAIAPIKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
}

