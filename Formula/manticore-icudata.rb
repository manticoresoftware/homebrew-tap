class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "65l"
  license "UNICODE, INC. LICENSE"

  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-icudata-65l.tar.gz"
  sha256 "a0f52348e563328cacf3efb4c40660b4dd69b2ae75885dd3fb0cd1985ce33b06"

  def install
    (share/"manticore/icu").mkpath
    share.install "manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
