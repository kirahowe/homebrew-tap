class RelayTui < Formula
  desc "Terminal dashboard for relay"
  homepage "https://github.com/kirahowe/relay-tui"
  license "MIT"
  head "https://github.com/kirahowe/relay-tui.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/relay-tui"
  end

  test do
    assert_match "usage: relay-tui", shell_output("#{bin}/relay-tui --help 2>&1", 2)
  end
end
