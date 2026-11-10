class Pi < Formula
  desc "Coding agent CLI with read, bash, edit, write tools and session management"
  homepage "https://pi.dev"
  url "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-1.5.2.tgz"
  sha256 "691bde186273b457d9d1c41d0fd47b57853b5e85ded1add1a1f6b78e66c261f4"
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
