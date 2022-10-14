class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://github.com/manticoresoftware/manticoresearch/archive/refs/tags/5.0.3.tar.gz"
  sha256 "416b9e609529af9cf9570b41e3e770de9511c5ed4d0c27530bfec7da396b13b2"
  license "GPL-2.0-only"
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-5.0.3"
    rebuild 1
    sha256 arm64_big_sur: "2ef4e45e17ed6d92eb033b59512ccf355703d1126c7786fda7bf1a70c1439e18"
    sha256 big_sur:       "552c6c732e1c88d97b3c296766e7e4eafdcee2a982da42a4c76ea9cb503c82b8"
    sha256 catalina:      "3c57d87bdf999d0e6e647b398e221d5511f2c729b8b66face9475d3b075c830d"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "libpq" => :build
  depends_on "mysql" => :build
  depends_on "postgresql@14" => :build
  depends_on "openssl@1.1"
  depends_on "manticoresoftware/manticore/manticore-backup" => :recommended

  conflicts_with "sphinx", because: "manticore is a fork of sphinx"

  def install
    args = %W[
      -DCMAKE_INSTALL_LOCALSTATEDIR=#{var}
      -DDISTR_BUILD=macosbrew
      -DBoost_NO_BOOST_CMAKE=ON
      -DWITH_ODBC=OFF
    ]

    # Disable support for Manticore Columnar Library on ARM (since the library itself doesn't support it as well)
    args << "-DWITH_COLUMNAR=OFF" if Hardware::CPU.arm?

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *args
      system "make", "install"
    end
  end

  def post_install
    (var/"run/manticore").mkpath
    (var/"log/manticore").mkpath
    (var/"manticore/data").mkpath
  end

  service do
    run [opt_bin/"searchd", "--config", etc/"manticoresearch/manticore.conf", "--nodetach"]
    keep_alive false
    working_dir HOMEBREW_PREFIX
  end

  test do
    (testpath/"manticore.conf").write <<~EOS
      searchd {
        pid_file = searchd.pid
        binlog_path=#
      }
    EOS
    pid = fork do
      exec bin/"searchd"
    end
  ensure
    Process.kill(9, pid)
    Process.wait(pid)
  end
end
