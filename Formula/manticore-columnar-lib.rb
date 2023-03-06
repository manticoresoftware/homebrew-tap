class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar.git", branch: "columnar-2.0.4", revision: "5a49bd7f07b7123edb5bc34503db80a870183de6"
  version "2.0.4-2023030613-5a49bd7"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/columnar.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-2.0.0-2023020711-a7c703d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "200747b6f211c4a0c054c67a626b0f89852eaa6b534c49c1665994722320cb7a"
    sha256 cellar: :any_skip_relocation, monterey:      "d99a53878426eca7d535c96909d716badfd1b68f3674c3b4fb98f82dccee7b98"
    sha256 cellar: :any_skip_relocation, big_sur:       "94f84f26a7b738d1327a3c5e739d9828bd842c2d175a0f9b6b4acfcb4c4d38a5"
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
