require 'hardware'

class Manticoresearch < Formula
  desc "Open source database for search"
  homepage "https://manticoresearch.com"
  license "GPL-3.0"

  arch = Hardware::CPU.arch
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-6.3.8-24112202-d17bd2b6b-osx11.6-#{arch}-main.tar.gz"
  version "6.3.8-24112202-d17bd2b6b"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "10c35f55b457dcf389ba39ee370e17c27d57c31f7eeb541c280b4e012d6ecc32"
  else
    sha256 "3573f6b5c41d7fd8785db087120746bc30ea18b6de2bb853e6f4e4024cab1915"
  end

  depends_on "libpq"
  depends_on "mysql-client"
  depends_on "openssl@1.1"
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
