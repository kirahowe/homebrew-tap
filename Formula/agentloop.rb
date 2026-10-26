class Agentloop < Formula
  desc "Runs a language model in a loop with tools, for relay"
  homepage "https://github.com/kirahowe/agentloop"
  license "MIT"
  head "https://github.com/kirahowe/agentloop.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/agentloop"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentloop version")
  end
end
