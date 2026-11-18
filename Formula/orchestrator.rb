class Orchestrator < Formula
  desc "Application-level traffic manager for Kubernetes clusters and VM pools"
  homepage "https://github.com/jdansak/orchestrator"
  license "Apache-2.0"
  head "https://github.com/jdansak/orchestrator.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/orchestrator")
    system "cargo", "install", *std_cargo_args(path: "crates/orchestrator-manager")
  end

  test do
    assert_path_exists bin/"orchestrator"
    assert_path_exists bin/"orchestrator-manager"
  end
end
