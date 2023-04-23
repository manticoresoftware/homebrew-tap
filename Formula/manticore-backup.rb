class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup.git", branch: "main", revision: "cde50086e0b80eb5b997c704eb59228af42f12d5"
  version "0.5.2-2023041808-cde5008"
  license "GPL-2.0"

  depends_on "composer" => :build
  depends_on "php" => :build

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build", "--name=\"Manticore Backup\"", "--package=manticore-backup", "--index=src/main.php"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    File.file? "#{bin}/manticore-backup"
  end
end
