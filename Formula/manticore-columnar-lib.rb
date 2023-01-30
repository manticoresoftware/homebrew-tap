class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar/archive/1.16.1.tar.gz"
  url "https://github.com/manticoresoftware/columnar.git", revision: "d0da46228b3c06b7a30aad9c9b8abce1ee3cba71"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-1.16.1"
    sha256 cellar: :any_skip_relocation, monterey: "755471f795b0eadc759d6d83ab502e426edebe12a20e5bcc8fc29ddbe0a58540"
    sha256 cellar: :any_skip_relocation, big_sur:  "8dca2c99a7e2acc5696913c81b898e6b2bee3d584cc3afd14ac1cf046780da4e"
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
