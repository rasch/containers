# Firefox Configuration

This is a basic outline of how I configure my Firefox profile(s). I use a few
different profiles for various usage/privacy requirements.

## Create New Profile(s)

1. Visit `about:profiles` in the urlbar.
2. Click the "Create a New Profile" button and follow the instructions at the
   prompts.
3. \[optional\] Once the new profile has been created set it as the default.
4. Take note of the path of the profile directory. Exit the browser.

## Setup user.js and chrome

Use the `firefox-config` script to setup the Dracula theme with my personal
modifications and a `user.js` file. Change directories to the profile directory
noted from above before running the script. Use one of the following examples
(or all of them by creating multiple profiles).

```sh
firefox-config betterfox userjs dracula userchrome
firefox-config arkenfox fastfox peskyfox userjs dracula userchrome
firefox-config arkenfox
# or your own ...
```

If using the Dracula chrome/theme, enable it by switching to the Dark theme in
`about:addons`.

## Configure Default Search Engine

1. Visit `about:preferences#search` in the urlbar.
2. Set the default search engine to SearXNG, DuckDuckGo or a similar privacy
   respecting option.

## Install & Configure Addons

### [uBlock Origin][1]

- Enable [medium blocking mode][2]
- Enable AdGuard URL Tracking Protection
- Import [Actually Legitimate URL Shortener Tool][3] custom filter list

See the [Arkenfox extensions wiki page][4] for more details.

[1]: https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
[2]: https://github.com/gorhill/uBlock/wiki/Blocking-mode:-medium-mode#how-to-enable-this-mode
[3]: https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt
[4]: https://github.com/arkenfox/user.js/wiki/4.1-Extensions#-recommended

### [Tridactyl][5]

- Source personal configuration file

```
:source --url https://cdn.jsdelivr.net/gh/rasch/containers/firefox/config/tridactylrc
```

[5]: https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/

### [Dark Reader][6]

1. Click "Dev tools", then "Preview New Design"
2. Close the Dev tools
3. Click "See all options", then "Colors" and choose the "Dracula" Color Scheme
   in the dropdown menu.

[6]: https://addons.mozilla.org/en-US/firefox/addon/darkreader/

### [Bitwarden][7]

If not using Bitwarden, install a different password manager.

[7]: https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/

### [Skip Redirect][8]

- Provides link tracking protection.
- If the window that pops up every time a redirect is skipped gets annoying,
  disable it in the settings.

[8]: https://addons.mozilla.org/en-US/firefox/addon/skip-redirect/

### [CanvasBlocker][9]

Install CanvasBlocker to prevent (some) fingerprinting (only if not using
Firefox's built-in resistFingerprinting option). Only use randomize canvas and
webgl, the rest is not needed.

[9]: https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/

### [Bypass Paywalls Clean][10]

This one isn't in Mozilla Addons, so it will need to be downloaded and installed
from the file system.

[10]: https://gitlab.com/magnolia1234/bpc-uploads/-/raw/master/bypass_paywalls_clean-latest.xpi

## Other Details

- Customize the toolbar (by right clicking and selecting "Customize Toolbar").
- Configure [DuckDuckGo][11] to use [Dracula Theme][12].
- Open `about:preferences#privacy` in a Firefox tab. In the "Cookies and Site
  Data" section, click "Manage Exceptions" and add any sites that you want to
  stay signed into.

[11]: https://start.duckduckgo.com/
[12]: https://draculatheme.com/duckduckgo

---

## Additional Resources

- [Arkenfox user.js](https://github.com/arkenfox/user.js)
- [Betterfox user.js](https://github.com/yokoffing/Betterfox)
- [Arch Wiki Firefox](https://wiki.archlinux.org/title/Firefox)
- [Arch Wiki Firefox/Privacy](https://wiki.archlinux.org/title/Firefox/Privacy)
- [Dracula Firefox Theme](https://github.com/dracula/firefox)
- [Dracula Tridactyl Theme](https://github.com/dracula/tridactyl)
- [Tridactyl](https://github.com/tridactyl/tridactyl)
- [Browser Toolbox](https://firefox-source-docs.mozilla.org/devtools-user/browser_toolbox/index.html)
- [Am I Unique?](https://amiunique.org)
