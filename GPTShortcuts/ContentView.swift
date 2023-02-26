//
//  ContentView.swift
//  GPTShortcuts
//
//  Created by Sash Zats on 2/25/23.
//

import Setting
import SwiftUI

struct ContentView: View {
    @AppStorage(ViewModel.shared.kAPIKeyStorageKey) var apiKey = ""
    
    var body: some View {
        return SettingStack {
            SettingPage(title: Bundle.main.localizedAppName ?? "") {
                SettingGroup(header: "Main", footer: "Currently app only works if you have an API key") {
                    SettingTextField(placeholder: "API key", text: $apiKey)
                }
                SettingGroup() {
                    SettingButton(title: "Get API key", indicator: "safari") {
                        UIApplication.shared.open(URL(string: "https://platform.openai.com/account/api-keys")!)
                    }
                    SettingButton(title: "See usage", indicator: "safari") {
                        UIApplication.shared.open(URL(string: "https://platform.openai.com/account/usage")!)
                    }
                    SettingButton(title: "Support", indicator: "envelope") {
                        UIApplication.shared.open(URL(string: "mailto:sash@zats.io")!)
                    }
                }
                SettingCustomView {
                    HStack() {
                        Image("Geppetto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160)
                            .cornerRadius(30)
                            .padding(20)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Bundle {
    var localizedAppName: String? {
        return (object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
                ?? object(forInfoDictionaryKey: "CFBundleName") as? String)
    }
}
