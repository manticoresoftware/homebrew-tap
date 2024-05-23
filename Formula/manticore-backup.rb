require "fileutils"

class ManticoreBackup < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-3.0"

  version "1.3.8-24052208-57fc406"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-backup_#{version}.tar.gz"
  sha256 "5ea04229f2b3e261780e812fd0e493c5b938fc421e284806eb1419821b0318e5"

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
