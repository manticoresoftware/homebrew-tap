class ManticoreColumnarLib < Formula
  desc "Manticore Columnar Library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar.git", branch: "2.0.0", revision: "a7c703d90351b696a58ab6573059fac7b5aa8283"
  version "2.0.0-2023020711-a7c703d"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/columnar.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-2.0.0-2023020620-a7c703d"
    sha256 cellar: :any_skip_relocation, monterey: "d36d9100b691a78a5599c7c17c6fb59e8d02289e788c39864979186f988175a2"
    sha256 cellar: :any_skip_relocation, big_sur:  "5926362c96b1f396f67f472c3884c3e34af4569b64e2fb77022f59a8b8ac17f6"
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
