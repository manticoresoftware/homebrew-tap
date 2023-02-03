class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar.git", branch: "2.0.0", revision: "a7c703d90351b696a58ab6573059fac7b5aa8283"
  version "2.0.0-2023013023-a7c703d"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/columnar.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-1.16.1-2023012002-d0da462"
    sha256 cellar: :any_skip_relocation, monterey: "b0fc85d8e763c8c7ab993032a7e2aaff9cb1a037700ca86c62977e69fcd03f5a"
    sha256 cellar: :any_skip_relocation, big_sur:  "9262e53bdc065f752484b1060bb94f010f73d23aa39c7a1fb589e613a71736b2"
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
