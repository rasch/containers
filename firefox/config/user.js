// Enable [Dracula] theme colors for icons.
user_pref("svg.context-properties.content.enabled", true);

// Disable `Alt` key opening menu bar (interferes with my window manager).
// `Alt-f` still opens the menu bar with the file menu selected.
user_pref("ui.key.menuAccessKeyFocuses", false);

// Enable session restore.
user_pref("browser.startup.page", 3);

// Enable search engine suggestions.
user_pref("browser.search.suggest.enabled", true);

// Disable Firefox sync.
user_pref("identity.fxaccounts.enabled", false);

// [ARKENFOX OVERRIDES]
// Disable fingerprint resistance (for dark mode and gaming).
user_pref("privacy.resistFingerprinting", false);
user_pref("privacy.resistFingerprinting.letterboxing", false);
user_pref("webgl.disabled", false);

// History is required for session restore.
user_pref("privacy.clearOnShutdown.history", false);

// Don't ask to save passwords.
user_pref("signon.rememberSignons", false);

// [BETTERFOX OVERRIDES]
// clear all browsing data on shutdown (except history)
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", true);
user_pref("browser.sessionstore.privacy_level", 2);
