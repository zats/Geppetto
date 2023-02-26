import AppIntents

struct AppShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: ExecuteGPTIntent(),
            phrases: [
                "Ask \(.applicationName)",
                "Ask GPT",
                "\(.applicationName) answer the question",
            ])
    }
}
