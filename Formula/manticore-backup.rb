require "fileutils"

class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-3.0"

  version "1.9.5+25060614-6bfc96f0"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-backup_#{version}.tar.gz"
  sha256 "358e46c621d56f0fb09b140cb39fa78c401473305ae016f3339e58b13e2b934e"

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
