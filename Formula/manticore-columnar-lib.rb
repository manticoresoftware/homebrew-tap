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
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "97f684c1403d7ea35899a0cf0ab60ace5d23e3e670976202655830a9a7a500f4"
    sha256 cellar: :any_skip_relocation, big_sur:  "70543fc3c4690cc6b217c6a06dcbdc04683ccff242bef138ee0067a04c0b953d"
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
