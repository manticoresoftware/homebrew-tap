require_relative 'manticore_helper'
require 'hardware'
require "fileutils"

class ManticoreBuddyDev < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-2.0"

  arch = Hardware::CPU.arch
  base_url = 'https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/'
  fetched_info = ManticoreHelper.fetch_version_and_url(
    'manticore-buddy',
    base_url,
    /(manticore-buddy_)(\d+\.\d+\.\d+)(_)(\d+\.)([\w]+)(\.tar\.gz)/
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]

  depends_on "curl"

  def install
    (share/"manticore").mkpath
    (share/"manticore/modules").mkpath
    (lib/"manticore").mkpath
    share.install "share/modules/manticore-buddy" => "manticore/modules/manticore-buddy"
    share.install "bin" => "manticore/modules/manticore-buddy"
  end

  test do
    File.file? "#{share}/manticore/modules/manticore-buddy/src/main.php"
    File.file? "#{bin}/manticore-buddy"
  end
end
