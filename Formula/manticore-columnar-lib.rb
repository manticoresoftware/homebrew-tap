require 'hardware'

class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  version "4.2.0-25032808-417f074"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-#{version}-osx11.6-#{arch}.tar.gz"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "b17e7705a64ee941d9766b1b74ea3847a4d2139edad96cbed7807bcd114408da"
  else
    sha256 "da2c68517d8f203365ef68e82e6d10d6afaa72d7cfdfcbf0a13d9a6af4544146"
  end

  def install
    (share/"manticore/modules").mkpath
    share.install "usr/local/share/manticore/modules/lib_manticore_columnar.so" => "manticore/modules/lib_manticore_columnar.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_secondary.so" => "manticore/modules/lib_manticore_secondary.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_knn.so" => "manticore/modules/lib_manticore_knn.so"
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
