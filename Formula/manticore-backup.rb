class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup/archive/refs/tags/v0.2.13.tar.gz"
  sha256 "afc97a8261ec75b3fb6c7d22f032fdc227faf137891a7575622c496e153f9295"

  bottle do
    rebuild 1
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
