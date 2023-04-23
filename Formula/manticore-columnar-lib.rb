class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  version "2.0.5-230422-24e76dd"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-columnar-lib-2.0.5-230422-24e76dd-osx11.6-x86_64.tar.gz"
      sha256 "24e46777084298c9abb1e6b0352d4f5935493dd89da804dc548aa17fd686d06d"
    end
    on_arm do
      url "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-columnar-lib-2.0.5-230422-24e76dd-osx11.6-arm64.tar.gz"
      sha256 "4db7e63ee48e0c0ef1ea0fe3f99250bc39954078f758af3df0ea1b81f6f5b03e"
    end
  end

  def install
    (share/"manticore/modules").mkpath
    share.install "usr/local/share/manticore/modules/lib_manticore_columnar.so" => "manticore/modules/lib_manticore_columnar.so"
    share.install "usr/local/share/manticore/modules/lib_manticore_secondary.so" => "manticore/modules/lib_manticore_secondary.so"
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
