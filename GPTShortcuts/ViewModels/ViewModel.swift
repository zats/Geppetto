//
//  ViewModel.swift
//  GPTShortcuts
//
//  Created by Sash Zats on 2/25/23.
//

import Foundation
import OpenAISwift

class ViewModel: NSObject {
    static let shared: ViewModel = ViewModel()
    
    public let kAPIKeyStorageKey = "kAPIKey"
    
    var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: kAPIKeyStorageKey)
            openAI = OpenAISwift(authToken: apiKey)
        }
    }
    
    private lazy var openAI = OpenAISwift(authToken: apiKey)
    
    override init() {
        if let apiKey = UserDefaults.standard.value(forKey: kAPIKeyStorageKey) as? String {
            self.apiKey = apiKey
        } else {
            self.apiKey = INSERT_YOUR_DEFAULT_KEY_STRING_HERE
        }
        super.init()
        UserDefaults.standard.addObserver(self, forKeyPath: kAPIKeyStorageKey, options: [.new], context: nil)
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: kAPIKeyStorageKey)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let newValue = change?[.newKey] as? String, object != nil, keyPath == kAPIKeyStorageKey else { return }
        self.apiKey = newValue
    }

    func complete(prefix: String, query: String, tokensCount: Int?, temperature: Double?) async throws -> String? {
        let result = try await openAI.sendCompletion(with: "\(prefix) \(query)", model: .gpt3(.davinci), maxTokens: tokensCount ?? 16, temperature: temperature ?? 0.8)
        return result.choices.first?.text
    }
}
