class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup.git", branch: "0.5.2", revision: "4a3793286c03860ce1b0c46ebee6c6f58a1948de"
  version "0.5.2-2023020222-4a37932"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch-backup.git"

  depends_on "composer" => :build
  depends_on "php" => :build
  depends_on "php" => :test

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build", "--name=\"Manticore Backup\"", "--package=manticore-backup", "--index=src/main.php"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    system "#{bin}/manticore-backup", "--version"
  end
end
