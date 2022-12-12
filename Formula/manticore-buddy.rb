require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  url "https://github.com/manticoresoftware/manticoresearch-buddy/archive/refs/tags/v0.1.15.tar.gz"
  sha256 "f7c7fd7ef80b2883871ba11b858c9bb3a62583c05e04630682719a352bb4a60a"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-buddy-0.1.15"
    sha256 cellar: :any_skip_relocation, monterey: "57eebf86b1796890074dbd630e1d28fc4cf0a32a9c4e60fafe0bf9f1812b9dd1"
    sha256 cellar: :any_skip_relocation, big_sur:  "9641dc569f52d23ecfb83b44c59eae46811d86bb454c06af6cd9ff92dd1c05a0"
  end

  depends_on "composer" => :build
  depends_on "php" => :build
  depends_on "php" => :test
  depends_on "curl"

  def install
    build_dir = `pwd`.strip + "/build"
    system "./bin/build", "--name=\"Manticore Buddy\"", "--package=manticore-buddy", "--index=src/main.php"
    dir = share
    mkdir_p "#{dir}/manticore/modules"
    mv "#{build_dir}/manticore-buddy", "#{dir}/manticore/modules/manticore-buddy"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/modules/manticore-buddy"
  end
end
