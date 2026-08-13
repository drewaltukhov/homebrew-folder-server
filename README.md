# homebrew-folder-server

Homebrew tap for [folder-server](https://github.com/drewaltukhov/folder-server) —
serve any folder at a local `.test` domain over HTTPS.

## Install

```sh
brew install drewaltukhov/folder-server/folder-server
fs setup
```

`fs setup` installs the mkcert local CA, writes the dnsmasq and Caddy config,
and prints a few one-time `sudo` lines to run (starting dnsmasq/caddy in the
system domain and adding the `*.test` DNS resolver).

Or tap first:

```sh
brew tap drewaltukhov/folder-server
brew install folder-server
```

Or in a `Brewfile`:

```ruby
tap "drewaltukhov/folder-server"
brew "folder-server"
```

## What the formula pulls in

`caddy`, `dnsmasq`, `fzf`, `gum`, and `mkcert` are installed as dependencies.

PHP and MySQL are deliberately **not** dependencies — folder-server never
installs or removes them, so you stay in control of which versions are on the
machine. Install what a project needs (`brew install php`, `brew install mysql`).

## Releasing a new version

1. Bump the version string in `bin/folder-server` (the `version` command
   prints it, and the formula's `test do` block asserts the two match).
2. Tag and push the release in the upstream repo.
3. The `brew bump` workflow opens a PR here with the new `url` and `sha256`,
   or bump it by hand.

## Why a tap and not homebrew/core

`homebrew/core` requires a self-submitted project to have at least 90 forks,
90 watchers, or 225 stars. Until then, this tap is the supported route —
Homebrew explicitly recommends a third-party tap for software that doesn't
meet the core criteria.
