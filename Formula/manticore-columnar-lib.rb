require 'hardware'

class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  version "10.2.0+26020513-9a5dd2f5"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-#{version}-osx11.6-#{arch}.tar.gz"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "6caa2ba40c2e7c344583fa794ff6ca8dc3a4fd443dca85ce53be08db47a562bf"
  else
    sha256 "af868b3f5c1ece2b0ab2fc0b9005563d75469291b88b1170e97a36d5748af881"
  end

  def install
    (share/"manticore/modules").mkpath
    share.install "usr/local/share/manticore/modules/lib_manticore_columnar.so" => "manticore/modules/lib_manticore_columnar.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_secondary.so" => "manticore/modules/lib_manticore_secondary.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_knn.so" => "manticore/modules/lib_manticore_knn.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_knn_embeddings.dylib" => "manticore/modules/lib_manticore_knn_embeddings.so"
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
