require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom build of PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.3.5+250708-6c4be4c"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-x86_64.tar.gz"
    sha256 "dd152d87b5c48e91b00134397d4aadf8b4a76c85de99597e3ef9738408b3bd87"
  else
    version "1.3.5+250708-6c4be4c"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-arm64.tar.gz"
    sha256 "00676b4c5e64a5ae2cdb4c5c002d1868ee409f7f48b0bce32bea7f4addbc10b8"
  end

  depends_on "openssl"
  depends_on "zstd"
  depends_on "oniguruma"
  depends_on "librdkafka"
  depends_on "libzip"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
