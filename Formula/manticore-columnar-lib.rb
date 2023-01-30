class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar.git", revision: "d0da46228b3c06b7a30aad9c9b8abce1ee3cba71"
  version "1.16.1-2023012002-d0da462"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/columnar.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-1.16.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, monterey: "fa5d7ebb979913507b94f0d6fd64cbcdde55fead521346766116254c48e8cdcf"
    sha256 cellar: :any_skip_relocation, big_sur:  "b8ce18fcdef7dbda56a01d9bff5cccd239ec1e6be87fe6ff9bf371a0345e4d5a"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build

  def install
    args = %W[
      -DCMAKE_INSTALL_LOCALSTATEDIR=#{var}
      -DDISTR_BUILD=macos
    ]

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *args
      system "make", "install"
    end
  end
  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/lib_manticore_columnar.so")
    assert_match "64-bit", output
  end
end
