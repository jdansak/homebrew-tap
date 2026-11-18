class CanvasScraper < Formula
  desc "CLI tool to scrape grades and assignments from Canvas LMS"
  homepage "https://github.com/jdansak/Canvas-Scraper"
  license "MIT"

  head do
    url "https://github.com/jdansak/Canvas-Scraper.git", branch: "main"
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.0.0/canvas-scraper-v1.0.0-darwin-arm64.tar.gz"
      sha256 "bde2807162f7bb671a300cc1113725edc4e8bb13fb41d6bf19a332af5419760f"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.0.0/canvas-scraper-v1.0.0-darwin-amd64.tar.gz"
      sha256 "cf8d09c2cb98a47885008813e87170bffc46e3cd85658210e259bc42a58b1c57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.0.0/canvas-scraper-v1.0.0-linux-arm64.tar.gz"
      sha256 "6833a2e23ae585aaf7bb8a8676bd1442377c6dcc5152755d1a5e5266ca57a438"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.0.0/canvas-scraper-v1.0.0-linux-amd64.tar.gz"
      sha256 "b6f7570a83f6e4aa6ec4af6b4af94f76bd23487eb9f69196c45d23491306eebc"
    end
  end

  def install
    if build.head?
      system "go", "build", *std_go_args(ldflags: "-s -w")
    else
      bin.install "canvas-scraper"
    end
  end

  test do
    assert_match "Usage", shell_output("#{bin}/canvas-scraper --help 2>&1", 2)
  end
end
