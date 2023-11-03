require_relative 'manticore_helper'

class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "65l"
  license "UNICODE, INC. LICENSE"

  filepath, sha256 = ManticoreHelper.download_file(
    'manticore-icudata',
    'https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-icudata-65l.tar.gz'
  )

  url "file://#{filepath}"
  sha256 sha256

  def install
    (share/"manticore/icu").mkpath
    share.install "manticore/icu/icudt65l.dat" => "manticore/icu/icudt65l.dat"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/icu"
  end
end
