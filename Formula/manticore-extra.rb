require 'hardware'

class ManticoreExtra < Formula
  desc "Manticore meta package to install manticore-executor and manticore-columnar-lib dependencies"
  homepage "https://manticoresearch.com"
  # manticore-extra.tgz is an archive with just one file README, just to comply with Homebrew's requirements
  url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-extra.tgz"
  sha256 "9fac38c1048f578b945b11f9c83347665f7c863fdbf15583365231ec459a51c4"

  # we take version of "executor"
  arch = Hardware::CPU.arch
  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "1.1.6-24052206-c55bc2b"
  else
    version "1.1.6-24052206-c55bc2b"
  end

  depends_on "manticoresoftware/tap/manticore-columnar-lib"
  depends_on "manticoresoftware/tap/manticore-executor"
  depends_on "manticoresoftware/tap/manticore-galera"

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
