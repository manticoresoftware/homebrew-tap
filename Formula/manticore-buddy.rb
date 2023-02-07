require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  url "https://github.com/manticoresoftware/manticoresearch-buddy.git", branch: "0.3.4", revision: "4798582904f6c64a6ebf7903094819e885b84481"
  version "0.3.4-2023020711-4798582"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch-buddy.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-buddy-0.3.4-2023020620-4798582"
    sha256 cellar: :any_skip_relocation, monterey: "80137b6726afe1a121cfdb5cd9e138cb98e861d23145c8a74148e8735d0625c4"
    sha256 cellar: :any_skip_relocation, big_sur:  "0d85cda0794d4e01ee4efc8553f4fb8fcb9efb15f00a90ed4d0ff1e4e5c03acc"
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
