class Nettui < Formula
  desc "Native macOS terminal UI for wired, wireless, VPN, and VLAN network settings"
  homepage "https://github.com/jdansak/OSX_network_TUI"
  license "MIT"
  head "https://github.com/jdansak/OSX_network_TUI.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"nettui"
  end
end
