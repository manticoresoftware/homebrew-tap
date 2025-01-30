require 'hardware'

class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  version "4.0.0-25012409-5aa8e43"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-#{version}-osx11.6-#{arch}.tar.gz"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "ebd83a80339adfb3d1fb7994de3baf919a16cadca8f2dcfba606f160a3ee9924"
  else
    sha256 "2661bfcd7da74190aa94187c09f474e8c1afcfd9dfce75c14da2f7745e850cb7"
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
