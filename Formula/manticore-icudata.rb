require "digest"
require "open-uri"
require "tempfile"

class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "2.0.4-2023030613-5a49bd7"
  license "UNICODE, INC. LICENSE"

  on_macos do
    # Download the file to a temporary directory
    tempfile = Tempfile.new("manticore-icudata")
    tempfile.binmode
    open("https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-icudata-65l.tar.gz", "rb") do |remote_file|
      tempfile.write(remote_file.read)
    end
    tempfile.close

    # Calculate the sha256 sum of the downloaded file
    sha256sum = Digest::SHA256.file(tempfile.path).hexdigest

    # Use the downloaded file and calculated hash in the formula
    url "file://#{tempfile.path}"
    sha256 sha256sum
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
