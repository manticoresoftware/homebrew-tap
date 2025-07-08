require "fileutils"

class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-3.0"

  version "1.9.6+25070510-5247d066"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-backup_#{version}.tar.gz"
  sha256 "fdb32b450f93dc3fc46743d0e263806b4a48417fc8359c50b5446f34612f3da8"

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
