class FirewallAudit < Formula
  desc "Cross-platform kernel-event firewall audit tool for minimal pinholes"
  homepage "https://github.com/jdansak/firewall-audit"
  head "https://github.com/jdansak/firewall-audit.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "firewall-audit", shell_output("#{bin}/firewall-audit --help")
  end
end
