# homebrew-tap

Homebrew tap for kirahowe's tools.

```sh
brew install --cask kirahowe/tap/editmd   # WYSIWYG markdown editor for macOS
brew install --cask kirahowe/tap/slk      # keyboard-driven Slack TUI
brew install --HEAD kirahowe/tap/relay    # personal agent; brings agentloop, relay-tui and webtool
```

- [editmd](https://github.com/kirahowe/editmd)
- [slk](https://github.com/kirahowe/slk)
- [relay](https://github.com/kirahowe/relay), with
  [agentloop](https://github.com/kirahowe/agentloop),
  [relay-tui](https://github.com/kirahowe/relay-tui) and
  [webtool](https://github.com/kirahowe/webtool)

The relay formulas build from `main` and have no releases yet, so they
install only with `--HEAD`. To upgrade, run
`brew upgrade --fetch-HEAD relay agentloop relay-tui webtool`, then
`brew services restart relay`.
