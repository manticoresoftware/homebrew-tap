class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://repo.manticoresearch.com/repository/manticoresearch_source/release/manticore-4.2.0-211223-15e927b28-release-source.tar.gz"
  sha256 "da2c3af17e62960244a536c3767a2978d36bec3d403293e4f51a4a6718e9c2cb"
  license "GPL-2.0-only"
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-4.2.0"
    sha256 arm64_big_sur: "a9ae578b05c3da46cedc07dd428d94a856aeae7f3ef80a0f405bf89b8cde893a"
    sha256 big_sur:       "5dc376aa20241233b76e2ec2c1d4e862443a0250916b2838a1ff871e8a6dc2c5"
    sha256 catalina:      "924afbbc16549d8c2b80544fd03104ff8c17a4b1460238e3ed17a1313391a2af"
    sha256 mojave:        "678d338adc7d6e8c352800fe03fc56660c796bd6da23eda2b1411fed18bd0d8d"
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
