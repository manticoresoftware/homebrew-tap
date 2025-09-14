class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "65l"
  license "UNICODE, INC. LICENSE"

  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-icudata-65l.tar.gz"
  sha256 "6fa1753993a243ef84ba9d56f280d8ea30d6a1c07b5f0e87b0255891df2c87e0"

  def install
    (share/"manticore/icu").mkpath
    share.install "manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
