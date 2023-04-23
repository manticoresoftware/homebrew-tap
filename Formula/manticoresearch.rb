class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://manticoresearch.com"
  version "6.0.5-230422-6257ae425"
  license "GPL-2.0"

  on_macos do
    on_intel do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-6.0.5-230423-7492254e7-osx11.6-x86_64-main.tar.gz"
      sha256 "12480e13c5f78061cc274968f9e95b76706cf2fa54d96ffa6ba3305969efe48c"
    end
    on_arm do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-6.0.5-230423-7492254e7-osx11.6-arm64-main.tar.gz"
      sha256 "7c9bb67c9deacff0bb969678edc58728eafaadea3070a92c4f7531f4313b1c57"
    end
  end

  depends_on "icu4c"
  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "openssl@1.1"
  depends_on "unixodbc"
  depends_on "zstd"
  depends_on "manticoresoftware/manticore-no-bottles/manticore-backup" => :recommended
  depends_on "manticoresoftware/manticore-no-bottles/manticore-buddy" => :recommended

  conflicts_with "sphinx", because: "Manticore Search is a fork of Sphinxsearch"

  def install
    bin.install Dir["local/bin/*"]
    man1.install Dir["local/share/doc/manticore/doc/*.1"]
    share.install "local/share/manticore"
    include.install "local/include/manticore"
    lib.install "local/var/lib/manticore"
    (etc/"manticoresearch").mkpath

    # HACK: /opt/homebrew instead of /usr/local
    source_contents = IO.read("local/etc/manticore/manticore.conf")
    modified_contents = source_contents.gsub(
      "/usr/local/var",
      "#{HOMEBREW_PREFIX}/var"
    )
    IO.write("local/etc/manticore/manticore.conf", modified_contents)
    etc.install "local/etc/manticore/manticore.conf" => "manticoresearch/manticore.conf"
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
