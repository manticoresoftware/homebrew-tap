require 'hardware'

class ManticoreExtra < Formula
  desc "Manticore meta package to install manticore-executor and manticore-columnar-lib dependencies"
  homepage "https://manticoresearch.com"
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-extra.tgz"
  sha256 "9fac38c1048f578b945b11f9c83347665f7c863fdbf15583365231ec459a51c4"

  # we take version of "executor"
  arch = Hardware::CPU.arch
  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "0.7.8-230822-810d7d3"
  else
    version "0.7.6-230804-8f5cfa5"
  end

  depends_on "manticoresoftware/tap/manticore-columnar-lib"
  depends_on "manticoresoftware/tap/manticore-executor"

  def install
    File.open("manticore-extra", "w") do |file|
      file.write "#!/bin/sh\n"
      deps.each do |dep|
        f = dep.to_formula
        file.write "echo " + [f.full_name, f.version, f.prefix].join("\t") + "\n"
      end
    end

    bin.install "manticore-extra"
  end

  test do
    system "#{bin}/manticore-extra"
  end
end
