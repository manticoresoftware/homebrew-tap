class ManticoreBackup < Formula
  desc "Official tool for backups of Manticore Search"
  homepage "https://github.com/manticoresoftware/manticoresearch-backup"
  url "https://github.com/manticoresoftware/manticoresearch-backup/archive/refs/tags/v0.2.17.tar.gz"
  sha256 "563ee88d6fe5fb5e38eb566fbd05399b3e280130ce2bec399078825057c1e3ce"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-backup-0.2.17"
    sha256 cellar: :any_skip_relocation, monterey: "8ff4c270bc547251029073ca7d589de70bff367e203a502c7cdb89b038371cd4"
    sha256 cellar: :any_skip_relocation, big_sur:  "7398dea4a9bd2082c41dbc0511136ff0413269907f95d38c88c1c4570cfda9b4"
  end

  depends_on "php" => :build
  depends_on "php" => :test

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build"
    bin.install "#{build_dir}/manticore-backup" => "manticore-backup"
  end

  test do
    system "#{bin}/manticore-backup", "--version"
  end
end
