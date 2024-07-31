class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "65l"
  license "UNICODE, INC. LICENSE"

  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-icudata-65l.tar.gz"
  sha256 "da7854b075eb74c16cb5f40941344daf6928dfab60a31b61e09a7984dcd8910c"

  def install
    (share/"manticore/icu").mkpath
    share.install "manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
