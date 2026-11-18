class CanvasScraper < Formula
  desc "CLI tool to scrape grades and assignments from Canvas LMS"
  homepage "https://github.com/jdansak/Canvas-Scraper"
  version "1.1.0"
  license "MIT"

  head do
    url "https://github.com/jdansak/Canvas-Scraper.git", branch: "main"
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.0/canvas-scraper-v1.1.0-darwin-arm64.tar.gz"
      sha256 "ec761e6986f32c2b670b60f26870cd8df7269d445a78becabaf188b1c765f00c"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.0/canvas-scraper-v1.1.0-darwin-amd64.tar.gz"
      sha256 "13ade84f74a01b141d9939562cecae98d051d53e46eb8c23f5954fa885d49ad8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.0/canvas-scraper-v1.1.0-linux-arm64.tar.gz"
      sha256 "36deac8d6964c8dcc3267ea312162d955f39eb80cf4b3ff9319a674df29564a7"
    end

    on_intel do
      url "https://github.com/jdansak/Canvas-Scraper/releases/download/v1.1.0/canvas-scraper-v1.1.0-linux-amd64.tar.gz"
      sha256 "6aec3d1aa0ff892171c3ff9f891487d305b32ae06188c064f06302d241c263a0"
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
    assert_match "v1.1.0", shell_output("#{bin}/canvas-scraper --version")
    assert_match "USAGE:", shell_output("#{bin}/canvas-scraper --help")
  end
end
