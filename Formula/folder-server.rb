class FolderServer < Formula
  desc "Serve any folder at a local .test domain over HTTPS"
  homepage "https://github.com/drewaltukhov/folder-server"
  url "https://github.com/drewaltukhov/folder-server/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e73f109510a27cbefa84ab15c4205a5b1219156fc985877292e5091a76a6b4e0"
  license "MIT"
  head "https://github.com/drewaltukhov/folder-server.git", branch: "main"

  # Track the upstream GitHub release, so `brew bump` opens a PR here on its
  # own instead of relying on a guessed strategy.
  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "caddy"
  depends_on "dnsmasq"
  depends_on "fzf"
  depends_on "gum"
  depends_on :macos
  depends_on "mkcert"

  def install
    # The entrypoint resolves its libs as ../lib relative to the *resolved*
    # symlink target, so bin/, lib/ and templates/ have to stay siblings.
    libexec.install "bin", "lib", "templates"
    bin.install_symlink libexec/"bin/folder-server"
    bin.install_symlink libexec/"bin/folder-server" => "fs"

    zsh_completion.install "completions/fs.zsh" => "_fs"
    bash_completion.install "completions/fs.bash" => "fs"
  end

  def caveats
    <<~EOS
      Finish the one-time machine setup:
        fs setup

      It installs the mkcert local CA, writes the dnsmasq and Caddy config, and
      then prints a few sudo lines to run once (starting dnsmasq/caddy in the
      system domain and adding the *.test DNS resolver).

      PHP and MySQL stay under your control — folder-server never installs or
      removes them. Install what a project needs, e.g.:
        brew install php
        brew install mysql
    EOS
  end

  test do
    assert_match "folder-server #{version}", shell_output("#{bin}/fs version")
    assert_match "Usage: fs <command>", shell_output("#{bin}/fs help")
    # Unknown commands must fail loudly rather than silently no-op.
    assert_match "unknown command", shell_output("#{bin}/fs nope 2>&1", 127)
  end
end
