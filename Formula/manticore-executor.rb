require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.1.12-24071807-0565a65"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_x86_64.tar.gz"
    sha256 "9824183ae8fa4de352091929bbe5ae7a978ed3930ecf2230e2d25620c9c0d07c"
  else
    version "1.1.12-24071807-0565a65"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_arm64.tar.gz"
    sha256 "1386bbc7a0e8c6366559e0fa1c0e136b287e7d921b0ee7bc6d853679f1d4c5a6"
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
