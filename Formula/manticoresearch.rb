class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://www.manticoresearch.com"
  url "https://github.com/manticoresoftware/manticoresearch.git", revision: "833705a1cd98ed48f75252e5a15fb869d99b1c61"
  version "5.0.3-2023013021-833705a"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticoresearch-5.0.3-2023013021-833705a"
    sha256 monterey: "e0e3eab002f6de77f7e1afc202bfdc9437e7a19380aabf04c284936f08e69db1"
    sha256 big_sur:  "598c1c4487e7b1e0cfdb42be1edf6381427e3b661748eb70ae69eda4724786e2"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "icu4c"
  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "openssl@1.1"
  depends_on "unixodbc"
  depends_on "zstd"
  depends_on "manticoresoftware/manticore/manticore-buddy" => :recommended
  depends_on "manticoresoftware/manticore/manticore-backup" => :recommended

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
