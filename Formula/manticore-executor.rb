require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom build of PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.3.6+25102902-defbddd7"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-x86_64.tar.gz"
    sha256 "e355e76a890586dddd38f29c41aba3cd822d1873964e103856b09569c6c058e7"
  else
    version "1.3.6+25102902-defbddd7"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor-#{version}-macos-arm64.tar.gz"
    sha256 "58dd48310ca4c26034ba5b13629fa105bac56256a1aad88a7b721554ddeb1c18"
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
