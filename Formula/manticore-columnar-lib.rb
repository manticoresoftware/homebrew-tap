class ManticoreColumnarLib < Formula
  desc "Column-oriented storage library"
  homepage "https://github.com/manticoresoftware/columnar/"
  url "https://github.com/manticoresoftware/columnar/archive/1.16.1.tar.gz"
  sha256 "2778e4d8c2fa065cc56d6071f602e5a8c76a0223456f6e046353d62639983d8b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-columnar-lib-1.16.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9c9fa5eebe3e28e807835ccf51b862712e338c32355ab8ed58152af0995ffed5"
    sha256 cellar: :any_skip_relocation, monterey:       "66d91f270ed6d61d229a55eb729210b9787b87b0c78db9e2cafe94c6bf466fc5"
    sha256 cellar: :any_skip_relocation, big_sur:        "62b4870f60aa6c369f14655ff8cff32df4e34eb3675cfb4475edd9398f198e4d"
    sha256 cellar: :any_skip_relocation, catalina:       "bd9d1601ffb98d3b0a78a5958da409ef2da8eafca6aaba7d84386ae1c8a232b8"
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
