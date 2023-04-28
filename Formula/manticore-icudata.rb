require "digest"
require "open-uri"
require "tmpdir"

class ManticoreIcudata < Formula
  desc "Chinese segmentation data file for Manticore Search"
  homepage "https://unicode-org.github.io/icu/userguide/icu_data/"
  version "2.0.4-2023030613-5a49bd7"
  license "UNICODE, INC. LICENSE"

  on_macos do
    tmpdir = Dir.mktmpdir
    filepath = "#{tmpdir}/manticore-icudata.tar.gz"
    File.open(filepath, "wb") do |saved_file|
      open("https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-icudata-65l.tar.gz", "rb") do |remote_file|
        saved_file.write(remote_file.read)
      end
    end

    url "file://#{filepath}"
    sha256 Digest::SHA256.file(filepath).hexdigest
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
