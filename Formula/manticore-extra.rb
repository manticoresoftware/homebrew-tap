require "digest"
require 'hardware'
require 'fileutils'

class ManticoreExtra < Formula
  desc "Manticore meta package to install manticore-executor and manticore-columnar-lib dependencies"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  puts "url file://" + File.expand_path(__FILE__)
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest
  puts "sha256 " + Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest

  url_sha256 = Digest::SHA256.hexdigest(url)
  FileUtils.rm(Dir.glob(HOMEBREW_CACHE/"downloads/#{url_sha256}--*"))

  # we take version of "executor"
  arch = Hardware::CPU.arch
  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "0.7.8-230822-810d7d3"
  else
    version "0.7.6-230804-8f5cfa5"
  end

  depends_on "sanikolaev/tap/manticore-columnar-lib"
  depends_on "sanikolaev/tap/manticore-executor"

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
