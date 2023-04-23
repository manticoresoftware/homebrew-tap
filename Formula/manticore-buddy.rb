require "fileutils"

class ManticoreBuddy < Formula
  desc "Manticore Search's sidecar which helps it with various tasks"
  homepage "https://github.com/manticoresoftware/manticoresearch-buddy"
  url "https://github.com/manticoresoftware/manticoresearch-buddy.git", branch: "main", revision: "4557b62a6e272c999286047f31b61a1101f24906"
  version "1.0.1-2023042014-4557b62"
  license "GPL-2.0"

  depends_on "composer" => :build
  depends_on "php" => :build
  depends_on "curl"

  def install
    build_dir = `pwd`.strip + "/build"
    system "git", "clone", "https://github.com/manticoresoftware/phar_builder.git"
    system "./phar_builder/bin/build", "--name=\"Manticore Buddy\"", "--package=manticore-buddy", "--index=src/main.php"
    (share/"manticore/modules/manticore-buddy/bin/").mkpath
    share.install "#{build_dir}/manticore-buddy" => "manticore/modules/manticore-buddy/bin/manticore-buddy"
    Dir["#{build_dir}/share/modules/manticore-buddy/*"].each do |file|
      file_name = File.basename(file)
      share.install file => "manticore/modules/manticore-buddy/#{file_name}"
    end
  end

  test do
    dir = share
    File.file? "#{dir}/manticore/modules/manticore-buddy/bin/manticore-buddy"
  end
end
