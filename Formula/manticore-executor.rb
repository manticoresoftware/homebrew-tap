require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.1.6-24052206-c55bc2b"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_x86_64.tar.gz"
    sha256 "4471bb83735a7f5e02aee786cccacfbf61c5d8b3c11ded238812bb49fdbdce32"
  else
    version "1.1.6-24052206-c55bc2b"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_arm64.tar.gz"
    sha256 "95dfe513e0f33743cea639ad1490cd0ea747ad298010fad24e9f7b38ee371073"
  end

  depends_on "openssl"
  depends_on "zstd"
  depends_on "oniguruma"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
