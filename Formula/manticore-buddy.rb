require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  license "GPL-3.0"

  version "3.26.5+25032712-234c30c2"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-buddy_#{version}.tar.gz"
  sha256 "6c18a3e958509c29eb714f552689fff979348a47a52d4a534df5ef36028003af"

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
