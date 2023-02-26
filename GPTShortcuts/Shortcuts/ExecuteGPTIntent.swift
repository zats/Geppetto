//
//  ExecuteGPTIntent.swift
//  GPTShortcuts
//
//  Created by Sash Zats on 2/25/23.
//

import AppIntents

struct ExecuteGPTIntent: AppIntent {
    static let title: LocalizedStringResource = "Ask GPT"

    @Parameter(title: "Prefix")
    var _prefix: String?

    @Parameter(title: "Query")
    var _query: String?

    
    @Parameter(title: "Number of tokens", default: 16)
    var tokensCount: Int?

    @Parameter(title: "Temperature", default: 0.8)
    var temperature: Double?

    @MainActor
    func perform() async throws -> some IntentResult {
        let prefix: String
        let query: String
        if let _prefix = _prefix {
            prefix = _prefix
        } else {
            prefix = try await $_prefix.requestValue()
        }
        if let _query = _query {
            query = _query
        } else {
            query = try await $_query.requestValue()
        }
        
        let result = try await ViewModel.shared.complete(prefix: prefix, query: query, tokensCount: tokensCount, temperature: temperature)
        return .result(value: result)
    }
}
