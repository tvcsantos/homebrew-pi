class Pi < Formula
  desc "Coding agent CLI with read, bash, edit, write tools and session management"
  homepage "https://pi.dev"
  url "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-1.6.1.tgz"
  sha256 "e3b0eb54b6e1e95b60ec7c4204959bd69adc51fb1f0da3a59430bbc9a593734f"
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
