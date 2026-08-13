# homebrew-folder-server

Homebrew tap for **[folder-server](https://github.com/drewaltukhov/folder-server)** —
serve any folder at a local `.test` domain over HTTPS.

This repo is just the packaging. Source, docs, issues, and releases all live in
the [main repo](https://github.com/drewaltukhov/folder-server). It exists as a
separate repo because `brew tap drewaltukhov/folder-server` resolves, by
Homebrew convention, to a repo named `homebrew-folder-server`.

## What it does

`fs` turns any folder into a local site at **`https://<name>.test`** with trusted
HTTPS, a PHP version you pick, optional MySQL, and a live terminal dashboard — all
from Homebrew packages and a handful of shell scripts. A tiny MAMP Pro replacement
for macOS. No Electron, no Intel binaries.

- 🌐 **Pretty local domains** — every folder gets `https://<name>.test` (dnsmasq + Caddy)
- 🔒 **Trusted HTTPS** — real browser-trusted certs per site (mkcert), no warnings
- 🐘 **Per-folder PHP** — pick any installed version per project, or default to your newest
- 📄 **Static and Node projects too** — plain folders, or a Vite/Astro/Next dev server
- 🗄️ **MySQL on demand** — opt in per project; database and user auto-provisioned
- 🖥️ **Live dashboard** — start/stop, edit config, view logs from `fs dash`

[Full documentation →](https://github.com/drewaltukhov/folder-server#readme)

## Install

```sh
brew install drewaltukhov/folder-server/folder-server
fs setup
```

Upgrade with `brew update && brew upgrade folder-server`.

## Maintaining

The formula is `Formula/folder-server.rb`. To ship a new version:

1. Bump the version string in `bin/folder-server` upstream — the formula's
   `test do` block asserts `fs version` matches the tag, so a forgotten bump
   fails CI.
2. Tag and release upstream.
3. The `brew bump` workflow runs daily and opens a PR here with the new `url`
   and `sha256`. Merge it — or do it by hand:
   `brew bump-formula-pr --no-fork --version=X.Y.Z drewaltukhov/folder-server/folder-server`

Before pushing a formula change, run `brew style` and
`brew audit --strict --online drewaltukhov/folder-server/folder-server`.
