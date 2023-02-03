class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar.git", branch: "2.0.0", revision: "a7c703d90351b696a58ab6573059fac7b5aa8283"
  version "2.0.0-2023013023-a7c703d"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/columnar.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-2.0.0-2023013023-a7c703d"
    sha256 cellar: :any_skip_relocation, monterey: "7944dccf08985c6da253f781a82d08be3af1fa0de4aa39fad33e37b12375d2d8"
    sha256 cellar: :any_skip_relocation, big_sur:  "2b58822eec2c957fff7b89d9aea67f6b16512801899b796e39db1a45befd30b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f7e604f3e12e3d98df8366e92037bb819e3bf02821cc957a80d8852705a66e46"
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
