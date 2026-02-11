require 'hardware'

class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  version "10.2.2+26021001-a705ab6c"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-#{version}-osx11.6-#{arch}.tar.gz"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "dfde31b6461e529227d4b48e43cbf5c80d5d51157930fec500306f6df1bee6ed"
  else
    sha256 "6f9d02efeb12e993aadf44ea62fb048ab5612ead8341eac0d266896a75cc8a80"
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
