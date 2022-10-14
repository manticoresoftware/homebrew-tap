class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup/archive/refs/tags/v0.2.15.tar.gz"
  sha256 "065c938eaf30a90332b2912c2aea4744c8dc5d5f697dde8ac3f6a8e3da184b00"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-backup-0.2.15"
    sha256 cellar: :any_skip_relocation, monterey: "e0fd0326a4e508f0eef9e6e76934ffedff0531ee80b40c78cb81053d76720f5c"
    sha256 cellar: :any_skip_relocation, big_sur:  "047abfe0246c884a9f3710714c7f78ebc2848b58f94dc443d617efb22708e018"
  end

  depends_on "php" => :build
  depends_on "manticoresoftware/manticore/manticore-executor"

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    system "#{bin}/manticore-backup", "--version"
  end
end
