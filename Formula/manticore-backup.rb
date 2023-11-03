require "fileutils"

class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-2.0"

  version "1.0.8-23080408-f7638f9"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-backup_#{version}.tar.gz"
  sha256 "68932860d63563ff3d4dd55b5279344a5827fdcf652e0c424e6f39920f8085f8"

  def install
    (share/"manticore").mkpath
    share.install "share/modules" => "manticore/modules"
    bin.install "bin/manticore-backup" => "manticore-backup"
  end

  test do
    File.file? "#{share}/manticore/modules/manticore-backup/src/main.php"
    File.file? "#{bin}/manticore-backup"
  end
end
