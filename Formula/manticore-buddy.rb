require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-3.0"

  version "3.37.0+25110512-4eee6020"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-buddy_#{version}.tar.gz"
  sha256 "c6d556c17bf5ffc646b85bcb55e562d88f47be7140a6174fbdb3253af285268a"

  depends_on "curl"

  def install
    (share/"manticore").mkpath
    (share/"manticore/modules").mkpath
    (lib/"manticore").mkpath
    share.install "share/modules/manticore-buddy" => "manticore/modules/manticore-buddy"
    share.install "bin" => "manticore/modules/manticore-buddy"
  end

  test do
    File.file? "#{share}/manticore/modules/manticore-buddy/src/main.php"
    File.file? "#{bin}/manticore-buddy"
  end
end
