class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://github.com/manticoresoftware/manticoresearch.git", branch: "manticore-6.0.0", revision: "7542cb76df91bcc3412082747ee3d651263dc36b"
  version "6.0.0-2023020313-e12d6a9"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-5.0.3-2023020218-7542cb7"
    sha256 monterey: "142f717f724c45ee23367e47b835fb3f7e1e99a6cee7ec85afafcf3df39ca616"
    sha256 big_sur:  "3d51359b31f0d8f18a93b4446b0c9ef46afc8ea625a748ef8a534927cded71b4"
    sha256 arm64_ventura: "25c05bd56597f30a6d75f1e21b9facb5504c640903b35eca26459f0e44bbb53e"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "icu4c"
  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "openssl@1.1"
  depends_on "unixodbc"
  depends_on "zstd"
  depends_on "manticoresoftware/manticore/manticore-backup" => :recommended
  depends_on "manticoresoftware/manticore/manticore-buddy" => :recommended

  conflicts_with "sphinx", because: "manticore is a fork of sphinx"

  fails_with gcc: "5"

  def install
    ENV["ICU_ROOT"] = Formula["icu4c"].opt_prefix.to_s
    ENV["OPENSSL_ROOT_DIR"] = Formula["openssl"].opt_prefix.to_s
    ENV["MYSQL_ROOT_DIR"] = Formula["mysql-client"].opt_prefix.to_s
    ENV["PostgreSQL_ROOT"] = Formula["libpq"].opt_prefix.to_s

    args = %W[
      -DHOMEBREW_PREFIX=#{HOMEBREW_PREFIX}
      -DDISTR_BUILD=homebrew
      -DWITH_ICU_FORCE_STATIC=OFF
      -D_LOCALSTATEDIR=#{var}
      -D_RUNSTATEDIR=#{var}/run
      -D_SYSCONFDIR=#{etc}
    ]

    mkdir "build" do
      system "cmake", "-S", "..", "-B", "build", *std_cmake_args, *args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
    end
  end

  def post_install
    (var/"run/manticore").mkpath
    (var/"log/manticore").mkpath
    (var/"manticore").mkpath

    # Fix old config path (actually it was always wrong and never worked; however let's check)
    mv etc/"manticore/manticore.conf", etc/"manticoresearch/manticore.conf" if (etc/"manticore/manticore.conf").exist?
  end

  service do
    run [opt_bin/"searchd", "--config", etc/"manticoresearch/manticore.conf", "--nodetach"]
    environment_variables PATH: std_service_path_env
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
