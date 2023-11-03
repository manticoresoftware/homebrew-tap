require_relative 'manticore_helper'
require 'hardware'

class ManticoreColumnarLibDev < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  base_url = 'https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/'
  fetched_info = ManticoreHelper.fetch_version_and_url(
    'manticore-columnar-lib',
    base_url,
    /(manticore-columnar-lib-)(\d+\.\d+\.\d+)(\-)(\d+-)([\w]+)(-osx11\.6-#{arch}\.tar\.gz)/
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]

  def install
    (share/"manticore/modules").mkpath
    share.install "usr/local/share/manticore/modules/lib_manticore_columnar.so" => "manticore/modules/lib_manticore_columnar.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_secondary.so" => "manticore/modules/lib_manticore_secondary.so"
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
