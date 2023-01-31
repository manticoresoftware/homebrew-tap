require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  url "https://github.com/manticoresoftware/manticoresearch-buddy.git", branch: "0.3.4", revision: "8cb84c11a328999226ecdd2dbb67ab8633176fa2"
  version "0.3.4-2023013117-8cb84c1"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch-buddy.git"

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
