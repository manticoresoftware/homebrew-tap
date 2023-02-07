require "digest"

class ManticoreExtra < Formula
  desc "Meta package that includes executor and columnar lib"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  version "0.6.2-2023020711-d95e43e" # Must be same as executor
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-extra-0.6.2-2023020620-d95e43e"
    sha256 cellar: :any_skip_relocation, monterey: "31c3259dcee9bf43aa17d1b69e62f1d45fa65426507823341dac3f50275210ac"
    sha256 cellar: :any_skip_relocation, big_sur:  "5d52633c3e757dd3a879cdec3a848bab7d073118826df0631c8d991bd7421446"
  end

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
