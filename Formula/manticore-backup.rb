require "fileutils"

class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-3.0"

  version "1.7.4+25012416-be8f7625"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-backup_#{version}.tar.gz"
  sha256 "4e349927641c43e52514ffb0912564b8ed78b1fa7620ba4ead6991fb0e1ba699"

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
