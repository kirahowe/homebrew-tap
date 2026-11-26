class Relay < Formula
  desc "Personal agent that prepares things and never acts as you"
  homepage "https://github.com/kirahowe/relay"
  license "MIT"
  head "https://github.com/kirahowe/relay.git", branch: "main"

  depends_on "borkdude/brew/babashka"
  depends_on "kirahowe/tap/agentloop"
  depends_on "kirahowe/tap/relay-tui"
  depends_on "kirahowe/tap/webtool"

  def install
    libexec.install "bin", "resources", "setup", "src"
    # relay reads Calendar and Reminders through its own EventKit binary,
    # which it looks for at tools/eventkit/eventkit under its install root.
    # macOS ties the access grant to the binary, so after an upgrade
    # `relay eventkit-access` may need running again in a terminal.
    if OS.mac?
      system "tools/eventkit/build.sh"
      (libexec/"tools/eventkit").install "tools/eventkit/eventkit"
    end
    # The repository's bb.edn carries test dependencies and tasks. bin/relay
    # only needs the paths, and a :deps entry would make bb fetch them.
    (libexec/"bb.edn").write "{:paths [\"src\" \"resources\"]}\n"
    bin.install_symlink libexec/"bin/relay"
  end

  def caveats
    <<~EOS
      Run relay to set it up. It asks for your Anthropic API key, which
      it keeps in your login keychain, and where to keep your data, and
      offers to keep running in the background.
      For a scripted setup, relay init still works: relay init --help.
    EOS
  end

  service do
    run [opt_bin/"relay", "run"]
    keep_alive true
    # A relay run that cannot start (no ~/.config/relay/config.edn yet,
    # say) is tried again once a minute, not every ten seconds.
    throttle_interval 60
    # relay run waits up to 25 seconds for relay serve to end its
    # conversations and for a running tick; launchd kills what is left
    # after this.
    stop_timeout 40
    log_path var/"log/relay.log"
    error_log_path var/"log/relay.log"
    # /usr/local/bin too, as relay's old launchd jobs had, for commands
    # that relay.edn names without a path.
    environment_variables PATH: "#{std_service_path_env}:/usr/local/bin"
  end

  test do
    # --data, so the test reads no config file of the user's.
    assert_match "relay memo steward", shell_output("#{bin}/relay help --data #{testpath}")
  end
end
