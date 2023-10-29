require_relative 'manticore_helper'
require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "GPL-2.0"

  arch = Hardware::CPU.arch
  puts "original arch: _#{arch}_"

  for i in 0...(arch.length)
    print "#{arch[i].ord} "
  end
  puts

  test = "x86_64"
  for i in 0...(test.length)
    print "#{test[i].ord} "
  end
  puts

  p arch
  p test

#  if arch == "x86_64"
  if arch.to_s == "x86_64"
    puts "x86_64 detected"
    arch = "(x86_64|amd64)"
  end
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
