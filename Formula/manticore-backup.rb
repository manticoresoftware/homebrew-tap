class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup.git", revision: "d2c86cbd3b812ce36a04123412d65c783ca8e8a9"
  version "0.5.3-2023030313-d2c86cb"
  license "GPL-2.0-or-later"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch-backup.git"

  depends_on "composer" => :build
  depends_on "php" => :build
  depends_on "php" => :test

  def install
    build_dir = `pwd`.strip + "/build"
    system "git", "clone", "https://github.com/manticoresoftware/phar_builder.git"
    system "./phar_builder/bin/build", "--name=\"Manticore Backup\"", "--package=manticore-backup", "--index=src/main.php"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    File.file? "#{bin}/manticore-backup"
  end
end
