class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "2.0.4-2023030613-5a49bd7"
  license "UNICODE, INC. LICENSE"

  on_macos do
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-icudata-65l.tar.gz"
    sha256 "cadbb22c51602448cf71a9cf3c5cedda624f38799cac7b1554153da2fd648d12"
  end

  def install
    (share/"manticore/icu").mkpath
    share.install "manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
