require "digest"

class ManticoreExtra < Formula
  desc "Meta package that includes executor and columnar lib"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  version "0.2.17" # Must be same as executor
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest

  depends_on "manticoresoftware/manticore/manticore-columnar-lib"
  depends_on "manticoresoftware/manticore/manticore-executor"

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
