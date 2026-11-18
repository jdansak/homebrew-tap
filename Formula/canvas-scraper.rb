class CanvasScraper < Formula
  desc "CLI tool to scrape grades and assignments from Canvas LMS"
  homepage "https://github.com/jdansak/Canvas-Scraper"
  version "1.1.2"
  license "MIT"

  head do
    url "https://github.com/jdansak/Canvas-Scraper.git", branch: "main"
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.2/canvas-scraper-v1.1.2-darwin-arm64.tar.gz"
      sha256 "67138cedb28ec4f3bb7462312d4d3497e6a91ad53472e0c3b9bd5aac71daa470"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.2/canvas-scraper-v1.1.2-darwin-amd64.tar.gz"
      sha256 "97a8c168cf6a1af32b3f6489acc59db6d7a2367750ce5e354e78464996c4ebed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.2/canvas-scraper-v1.1.2-linux-arm64.tar.gz"
      sha256 "410eb9b404f19be594bc985337a3cffb578befc3c2b910ee24094aebd6d4bf74"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.2/canvas-scraper-v1.1.2-linux-amd64.tar.gz"
      sha256 "feda14f77f99b7b740e3be218913073b0f546c3c588c9e7e2420507d70a14024"
    end
  end

  def install
    if build.head?
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=HEAD")
    else
      bin.install "canvas-scraper"
    end
  end

  test do
    assert_match "v1.1.2", shell_output("#{bin}/canvas-scraper --version")
    assert_match "USAGE:", shell_output("#{bin}/canvas-scraper --help")
  end
end
