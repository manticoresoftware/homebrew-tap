class ManticoreExecutor < Formula
  desc "Custom built PHP to run misc scripts of Manticore"
  homepage "https://github.com/manticoresoftware/executor"
  url "https://github.com/manticoresoftware/executor/archive/refs/tags/v0.2.17.tar.gz"
  sha256 "35889e913c00658c8a072df9bc63ffa999874d9877ef6c1c1f87aad2b1c2e424"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-executor-0.2.17"
    sha256 arm64_monterey:  "4a3580121c7833e1f1cd4e6e3217763e1307ed213c4eb018218bde6fcf35770c"
    sha256 monterey:        "627b401bbf787530e81965734098aa183f0a4a87bf2a9b99c34d610d350992c4"
    sha256 big_sur:         "c0ed3ff950eb12705b00307220a3c0296e00c7c05bb8cdf46dc6d98344d8162b"
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
