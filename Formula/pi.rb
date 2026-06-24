class Pi < Formula
  desc "Coding agent CLI with read, bash, edit, write tools and session management"
  homepage "https://pi.dev"
  url "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-0.80.2.tgz"
  sha256 "9cab186615345f3cc2ab1d35f7d6f139306a3122a030a45f7c245489f7349085"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@earendil-works/pi-coding-agent/latest"
    regex(/"version"\s*:\s*"([^"]+)"/i)
  end

  depends_on "fd"
  depends_on "node"
  depends_on "ripgrep"

  def install
    # Pi publishes npm-shrinkwrap.json, so we can safely bypass npm's
    # release-age gate without reopening transitive dependency ranges.
    system "npm", "install", *std_npm_args, "--min-release-age=0"
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pi --version")
  end
end
