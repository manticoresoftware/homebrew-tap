require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-3.0"

  version "3.40.2+25112823-27a2f87e"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-buddy_#{version}.tar.gz"
  sha256 "363d6f1392f7e9304b6c1e4f9e2b721d8a52677b93367894849b0d0ef580703a"

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
