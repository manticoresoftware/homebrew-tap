require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-2.0"

  version "2.3.10_24052208.7612a4f"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-buddy_#{version}.tar.gz"
  sha256 "6a739276d2689c1f96942e4855d1ea076cfe63ed16391999961b90f5fb33e32b"

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
