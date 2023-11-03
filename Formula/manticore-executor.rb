require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "GPL-2.0"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "0.7.8-230822-810d7d3"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_amd64.tar.gz"
    sha256 "db3822fcfccbdcda847e6a234b2ada0df83c23745bbbfe4e9522430e5a6246fe"
  else
    version "0.7.6-230804-8f5cfa5"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_arm64.tar.gz"
    sha256 "8969d93e933ee73c26dc56e832a3b0b621349b68b7f906a55a454544dd37d641"
  end

  depends_on "openssl"
  depends_on "zstd"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
