class MarketTui < Formula
  desc "Terminal UI for tracking stocks, crypto, options, and yield curve analytics"
  homepage "https://github.com/jdansak/market-tui"
  head "https://github.com/jdansak/market-tui.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"market_tui"
  end
end
