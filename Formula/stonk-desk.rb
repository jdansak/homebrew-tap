class StonkDesk < Formula
  desc "Terminal workstation for stocks, crypto, options Max Pain, insider trades, and yield curves"
  homepage "https://github.com/jdansak/stonk-desk"
  url "https://github.com/jdansak/stonk-desk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3d0ea18b6db9e971f0bea8adbc8ab85117a956d1eba933893e37179f6af13c8f"
  license "MIT"
  head "https://github.com/jdansak/stonk-desk.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"stonk"
  end
end
