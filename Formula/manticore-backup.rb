class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup/archive/refs/tags/v0.2.19.tar.gz"
  sha256 "cf8686374018437381e352425db4a78c8ecfc467fbc4144dda743e260b54ba6e"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-backup-0.2.19"
    sha256 cellar: :any_skip_relocation, monterey: "d98ccdeca65077a6824d7abc27adf655dea7f4e1f063efa171cdf7e94ae90b42"
    sha256 cellar: :any_skip_relocation, big_sur:  "ad03f485ab31811e3891b75839f97aff23b0727e41240fe7ec0269582f37d15a"
  end

  depends_on "php" => :build
  depends_on "php" => :test

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    system "#{bin}/manticore-backup", "--version"
  end
end
