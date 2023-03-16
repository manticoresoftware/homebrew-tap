require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  url "https://github.com/manticoresoftware/manticoresearch-buddy.git", branch: "0.4.2", revision: "36757ee752d6bc4dbbf3edaf3b3555ac57eac526"
  version "0.4.2-2023031314-36757ee"
  license "GPL-2.0"
  version_scheme 1
  head "https://github.com/manticoresoftware/manticoresearch-buddy.git"

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-buddy-0.3.4-2023020711-4798582"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "769af78c63f0dbc728a7eeb54ac0e8725b368715272b097983a0538389c095f8"
    sha256 cellar: :any_skip_relocation, monterey:      "da2f61fafdb1c125f4f12e5d96d2d3fade017508cb1915950b7c925e9579634f"
    sha256 cellar: :any_skip_relocation, big_sur:       "fe14c67e6aa0f0ffa49dd27553195e7708039c43bf53d15e68a04b8bd48a80a6"
  end

  depends_on "composer" => :build
  depends_on "php" => :build
  depends_on "php" => :test
  depends_on "curl"

  def install
    build_dir = `pwd`.strip + "/build"
    system "git", "clone", "https://github.com/manticoresoftware/phar_builder.git"
    system "./phar_builder/bin/build", "--name=\"Manticore Buddy\"", "--package=manticore-buddy",
"--index=src/main.php"
    dir = share
    mkdir_p "#{dir}/manticore/modules"
    mv "#{build_dir}/manticore-buddy", "#{dir}/manticore/modules/manticore-buddy"
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/modules/manticore-buddy"
  end
end
