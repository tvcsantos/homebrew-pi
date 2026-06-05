class Pi < Formula
  desc "Coding agent CLI with read, bash, edit, write tools and session management"
  homepage "https://pi.dev"
  url "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-0.78.1.tgz"
  sha256 "ef69821c383d92fd27e7d9adbdcb1e37621441e94c52348e47a2901ea9d7dd0c"
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
