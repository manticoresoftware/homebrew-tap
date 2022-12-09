class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  url "https://github.com/manticoresoftware/executor/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "ae62c5977a347d6b44b7ca2c1edd5d63a6d01cdc31f7fcc5d10fa8f16ec5d9e3"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-executor-0.4.5"
    sha256 monterey: "0b218c0e2756012d0a882a27d6d6da68de05d01827e173d9cd6baf9f94bd9ec0"
    sha256 big_sur:  "821d6c83a15af4983fc8b5d304f661aa60c22c38c7eb671820fc09fd4f4563e0"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "curl" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "re2c" => :build
  depends_on "openssl"
  depends_on "zstd"

  def install
    php_version = "8.1.13"
    php_dir = `pwd`.strip + "/build"
    system "./build-osx", php_version, "1"
    bin.install "#{php_dir}/dist/bin/php" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
