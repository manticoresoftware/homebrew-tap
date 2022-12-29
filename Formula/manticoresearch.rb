class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://github.com/manticoresoftware/manticoresearch/archive/refs/tags/5.0.3.tar.gz"
  sha256 "011560181fbb80c5c53cf8e8d0f2d2344cf78a5e07908eaa8f1fc84c84e9f64c"
  license "GPL-2.0"
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-5.0.3"
    rebuild 1
    sha256 monterey: "03cb693d15a62d78d4913fb35e2bd6c987fe42875c3e2b1be4a54bee7bc4e8de"
    sha256 big_sur:  "169a865e9664f19e6078e0569542703a193c0837a9340e83ab860627f81179ef"
    sha256 catalina: "a9fb628b2bee4c2390368d4a2593b200f0c509e74b41b441fe349e692a7945a2"
    sha256 arm64_monterey: "a721a28aa4e47223b9c78bc9cdabcfe4171226853533c6a0941c4c55bd54e39f"
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
