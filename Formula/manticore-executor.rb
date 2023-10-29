require_relative 'manticore_helper'
require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "GPL-2.0"

  original_arch = Hardware::CPU.arch
  puts "original_arch: #{original_arch}"
  arch = (original_arch == "x86_64") ? "(x86_64|amd64)" : original_arch
  puts "arch: #{arch}"
  base_url = 'https://repo.manticoresearch.com/repository/manticoresearch_macos/release/'
  fetched_info = ManticoreHelper.fetch_version_and_url(
    'manticore-executor',
    base_url,
    /(manticore-executor_)(\d+\.\d+\.\d+)(\-)(\d+\-)([\w]+)(_macos_#{arch}\.tar\.gz)/
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]

  depends_on "openssl"
  depends_on "zstd"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
