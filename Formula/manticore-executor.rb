class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  url "https://github.com/manticoresoftware/executor/archive/refs/tags/v0.2.15.tar.gz"
  sha256 "13dbe6638694eedab3ebd319514917cf0a2ef4724661aa5f45278cce17218dfa"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoreexecutor-0.1.0"
    sha256 cellar: :any_skip_relocation, big_sur:  "641c246014192ccb38c01387871b091df2cd377598f9806ff5849b33ad3f1805"
    sha256                               catalina: "e0c8cd3a71c844bfe0255268b4114815418fa7d53d7f2b00395fb72015264f81"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "curl" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "re2c" => :build
  depends_on "zstd"

  def install
    php_version = "8.1.11"
    php_dir = `pwd`.strip + "/php-src-php-#{php_version}"
    system "./build-osx", php_version, "1"
    bin.install "#{php_dir}/dist/bin/php" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
