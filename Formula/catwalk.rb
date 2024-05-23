class Catwalk < Formula
  desc "Soothing preview image generator for the high-spirited!"
  homepage "https://github.com/catppuccin/toolbox/tree/main/catwalk"
  url "https://github.com/catppuccin/toolbox/archive/refs/tags/whiskers-v2.1.1.tar.gz"
  sha256 "4b944492a59bf6ad8eb17656684a64fc8b638334f104cc3db521ccc755c2a69b"
  license "MIT"
  head "https://github.com/catppuccin/toolbox.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/catppuccin/tap"
    sha256 cellar: :any_skip_relocation, ventura:      "20a88a941680a641a88bff0d6e5ebdde2d1f8d8efc7e4db0ae91ef70bb8388ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a854dabeb866c6bb6a9d8220334a704267a93a46496a5ccfa06c3d82055c103f"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "catwalk")
    generate_completions_from_executable(bin/"catwalk", "completion")
  end

  test do
    assert_predicate (bin/"catwalk"), :exist?
  end
end
