require 'hardware'
require "fileutils"

class ManticoreExecutor < Formula
  desc "Custom build of PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  license "PHP-3.01"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.3.2-25012408-1856ac9"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_x86_64.tar.gz"
    sha256 "3de8579cf1d9eab0abed1868732d6a4e4a4189140ffafa63e1ec8a6db5b0fed4"
  else
    version "1.3.2-25012408-1856ac9"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_#{version}_macos_arm64.tar.gz"
    sha256 "7d3d9bd0aef545c59ae52d8b56bf47748829fb900cc53a866cea514f9d1172e2"
  end

  depends_on "openssl"
  depends_on "zstd"
  depends_on "oniguruma"
  depends_on "librdkafka"

  def install
    bin.install "manticore-executor" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
