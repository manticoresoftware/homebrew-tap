require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom build of PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.4.0+26012715-d7a66c60"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-x86_64.tar.gz"
    sha256 "536e99e7d116b977ebae978e0a1802ac7f37e1c00770fb3d728d7af536fd241f"
  else
    version "1.4.0+26012715-d7a66c60"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-arm64.tar.gz"
    sha256 "978c3fcb995ce436f3072308cba7678bf5e2bf7a70bcf5a1aa6c849c6c1a4671"
  end

  depends_on "openssl"
  depends_on "zstd"
  depends_on "oniguruma"
  depends_on "librdkafka"
  depends_on "libzip"
  depends_on "libiconv"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
