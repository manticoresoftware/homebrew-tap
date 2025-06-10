require 'hardware'

class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  license "Apache-2.0"

  arch = Hardware::CPU.arch
  version "5.0.1+25060311-59c70926"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-#{version}-osx11.6-#{arch}.tar.gz"

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    sha256 "b4f9223b2fc0259ae355b0c36516c314077cfbb651f40270bbef65dce47cd03c"
  else
    sha256 "1e99a070881b23fbe3fec4ec157f13e48b7f7e55dc3e489dca66a96c38c1166a"
  end

  def install
    (share/"manticore/modules").mkpath
    share.install "usr/local/share/manticore/modules/lib_manticore_columnar.so" => "manticore/modules/lib_manticore_columnar.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_secondary.so" => "manticore/modules/lib_manticore_secondary.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_knn.so" => "manticore/modules/lib_manticore_knn.so"
    share.install "usr/local/share/manticore/modules/libmanticore_knn_embeddings.dylib" => "manticore/modules/libmanticore_knn_embeddings.dylib"
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
