require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-3.0"

  version "3.41.0+26020401-6dae566d"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-buddy_#{version}.tar.gz"
  sha256 "12b8e8aeb4b3a5dbaa97319ca09a2ff95fa1cc3af20acb17d07479f9c0758f76"

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
