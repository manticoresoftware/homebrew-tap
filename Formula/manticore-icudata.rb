class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "2.0.4-2023030613-5a49bd7"
  license "UNICODE, INC. LICENSE"

  on_macos do
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-icudata-65l.tar.gz"
    sha256 "05a5dcb303cd8c152e83a489a74f205497313e8fe402ca7abd7870167a5a85e3"
  end

  def install
    (share/"manticore/icu").mkpath
    share.install "local/share/manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
