class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://manticoresearch.com"
  version "6.0.5-230424-eafab00da"
  license "GPL-2.0"

  on_macos do
    on_intel do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-6.0.5-230424-eafab00da-osx11.6-x86_64-main.tar.gz"
      sha256 "58f57ce11781a18e375280fe8cf6cf12f68741a19411dc2fdd2e7874a04c500a"
    end
    on_arm do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-6.0.5-230424-eafab00da-osx11.6-arm64-main.tar.gz"
      sha256 "e2feb7c0fdf8a81d886c516f20a2d95428ae2f6439dc9fccaee64c5ecbaa364b"
    end
  end

  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "openssl@1.1"
  depends_on "unixodbc"
  depends_on "zstd"
  depends_on "manticoresoftware/manticore-no-bottles/manticore-backup" => :recommended
  depends_on "manticoresoftware/manticore-no-bottles/manticore-buddy" => :recommended
  depends_on "manticoresoftware/manticore-no-bottles/manticore-icudata" => :recommended

  conflicts_with "sphinx", because: "Manticore Search is a fork of Sphinxsearch"

  def install
    bin.install Dir["bin/*"]
    man1.install Dir["share/doc/manticore/doc/*.1"]
    share.install "share/manticore"
    include.install "include/manticore"
    etc.install "etc/manticoresearch"
  end

  def post_install
    (var/"run/manticore").mkpath
    (var/"log/manticore").mkpath
    (var/"manticore").mkpath
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
      exec bin/"searchd", "--config", testpath/"manticore.conf"
    end
  ensure
    Process.kill(9, pid)
    Process.wait(pid)
  end
end
