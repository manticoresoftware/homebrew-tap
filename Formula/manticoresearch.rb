class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://repo.manticoresearch.com/repository/manticoresearch_source/release/manticore-4.2.0.tar.gz"
  sha256 "da2c3af17e62960244a536c3767a2978d36bec3d403293e4f51a4a6718e9c2cb"
  license "GPL-2.0-only"
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-4.0.2"
    rebuild 2
    sha256 big_sur:  "41cfb3ee3e282b7af66186e10eba83adb2ecf2ef99a32b4a8e0bf51eba1562bd"
    sha256 catalina: "b1d13d52f138077ef626a40991c2fa06730d8c154ba49cda950e18ca66d52e00"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "libpq" => :build
  depends_on "mysql" => :build
  depends_on "postgresql" => :build
  depends_on "openssl@1.1"

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
