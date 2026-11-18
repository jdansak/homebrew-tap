class CanvasScraper < Formula
  desc "CLI tool to scrape grades and assignments from Canvas LMS"
  homepage "https://github.com/jdansak/Canvas-Scraper"
  version "1.1.1"
  license "MIT"

  head do
    url "https://github.com/jdansak/Canvas-Scraper.git", branch: "main"
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.1/canvas-scraper-v1.1.1-darwin-arm64.tar.gz"
      sha256 "a9c0094f3706d47b69743780641b66c6df61f3735ab7b5105331fcacc608b235"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.1/canvas-scraper-v1.1.1-darwin-amd64.tar.gz"
      sha256 "3770b44be13332779cd8d67156e46ebfb9aef6856422c2cc4565a767942b3403"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.1/canvas-scraper-v1.1.1-linux-arm64.tar.gz"
      sha256 "98d43c2dfb5507ad74440e6433d795f3dd700536c3c9e92bea2ab72bcb1ad6e5"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.1/canvas-scraper-v1.1.1-linux-amd64.tar.gz"
      sha256 "a0ba1c34ff80ffffc7288e3a1c5233507575d7cc8b543b128a34f4f7b58aca4d"
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
    assert_match "v1.1.1", shell_output("#{bin}/canvas-scraper --version")
    assert_match "USAGE:", shell_output("#{bin}/canvas-scraper --help")
  end
end
