class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  url "https://github.com/manticoresoftware/executor.git", revision: "d95e43eb808a99e4da530ee95861ed18e6ba03b5"
  version "0.6.2-2023012314-d95e43e"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/executor.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-executor-0.6.2-2023012314-d95e43e"
    sha256 monterey: "83ba69a48bf4b86b9408d9ce5940a038f6136e4ecbc53ddf959fc13d8b92ac78"
    sha256 big_sur:  "8a116142999818e27e86073b2cfaab464157217e3ee3dbe4ab766c37be6a0cb4"
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
    php_version = "8.2.1"
    php_dir = `pwd`.strip + "/build"
    system "./build-osx", php_version, "1"
    bin.install "#{php_dir}/dist/bin/php" => "manticore-executor"
  end

  test do
    system "#{bin}/manticore-executor", "--version"
  end
end
