require "digest"

class ManticoreExtra < Formula
  desc "Meta package that includes executor and columnar lib"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  version "0.6.2-2023012313-d95e43e" # Must be same as executor  version_scheme 1
  version_scheme 1
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-extra-0.2.17"
    sha256 cellar: :any_skip_relocation, monterey: "d0fcd8c22bfd52302c6f6b32af3d343f365ed9b74a6940462a787b9ccf71e610"
    sha256 cellar: :any_skip_relocation, big_sur:  "0c888fc135db15e4d861ac5d5277836a29e895c7cafdb4822ab6d1e008b39b17"
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
