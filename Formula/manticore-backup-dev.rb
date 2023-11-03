require_relative 'manticore_helper'
require 'hardware'
require "fileutils"

class ManticoreBackupDev < Formula
  desc "Manticore Search backup tool"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  license "GPL-2.0"

  arch = Hardware::CPU.arch
  base_url = 'https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/'
  fetched_info = ManticoreHelper.fetch_version_and_url(
    'manticore-backup',
    base_url,
    /(manticore-backup_)(\d+\.\d+\.\d+)(\-)(\d+\-)([\w]+)(\.tar\.gz)/
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]

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
