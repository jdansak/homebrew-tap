class Bab < Formula
  desc "Pure-Rust TUI and CLI for provisioning, hardening, and managing Linux VPS"
  homepage "https://github.com/jdansak/VPS"
  head "https://github.com/jdansak/VPS.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "bab", shell_output("#{bin}/bab --help")
  end
end
