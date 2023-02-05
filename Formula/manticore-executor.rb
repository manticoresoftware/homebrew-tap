class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  url "https://github.com/manticoresoftware/executor.git", revision: "d95e43eb808a99e4da530ee95861ed18e6ba03b5"
  version "0.6.2-2023012313-d95e43e"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/executor.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-executor-0.6.2-2023012313-d95e43e"
    rebuild 1
    sha256 monterey: "c36fda714fce10a6913785e10a7322932dfe72b5e4f02a7892bc850380f2638a"
    sha256 big_sur:  "43e09456eaf522c380c9062668476dd1263d0e633458d901c13a1f85a6b069c7"
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
