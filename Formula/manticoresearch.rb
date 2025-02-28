require 'hardware'

class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://manticoresearch.com"
  license "GPL-3.0"

  arch = Hardware::CPU.arch
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-7.0.0-25013002-92c650401-osx11.6-#{arch}-main.tar.gz"
  version "7.4.6-25022808-b2ff82920"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "9ff2e1b64beb276e2cdd7ec3be787df74116a0ab8f197187e37eb8db5940f367"
  else
    sha256 "e2e566b1289a2a9025ea2defdb3d1856ef6adb0ac69d7141a403bad274a9888d"
  end

  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "unixodbc"
  depends_on "zstd"
  depends_on "manticoresoftware/tap/manticore-backup" => :recommended
  depends_on "manticoresoftware/tap/manticore-buddy" => :recommended
  depends_on "manticoresoftware/tap/manticore-icudata" => :recommended

  conflicts_with "sphinx", because: "Manticore Search is a fork of Sphinxsearch"

  def install
    bin.install Dir["bin/*"]
    man1.install Dir["share/doc/manticore/doc/*.1"]
    ln_s "/usr/share/zoneinfo", "share/manticore/tzdata"
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

  def caveats; <<~EOS
    If you're facing an issue with "too many open files", you may need to adjust your
    system's maxfiles limit. You can do this by executing the following command:

    sudo launchctl limit maxfiles 16384 65536

    Bear in mind, this will only establish the limit for the duration of your current
    login session. If you want this adjustment to be permanent, you'll need to modify
    your system's launchd configuration.
    EOS
  end

end
