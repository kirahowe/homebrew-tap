class Webtool < Formula
  desc "Web search and fetch for relay's public roles"
  homepage "https://github.com/kirahowe/webtool"
  license "MIT"
  head "https://github.com/kirahowe/webtool.git", branch: "main"

  depends_on "go" => :build

  def install
    # The release build only: the fixture build may fetch from a local
    # test server and is never installed.
    system "go", "build", *std_go_args, "./cmd/webtool"
    pkgshare.install "webtool.example.json"
  end

  test do
    assert_match "usage: webtool", shell_output("#{bin}/webtool --help 2>&1", 2)
  end
end
