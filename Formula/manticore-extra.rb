require "digest"

class ManticoreExtra < Formula
  desc "Meta package that includes executor and columnar lib"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  version "0.6.2-2023012314-d95e43e" # Must be same as executor
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest
  version_scheme 1

  bottle do
    root_url "https://github.com/manticoresoftware/homebrew-manticore/releases/download/manticore-extra-0.6.2-2023012313-d95e43e"
    sha256 cellar: :any_skip_relocation, monterey: "9ea2394e82e2deb77f026ccf2985a92412d97ec53383acf8f8f3ce8c2e045088"
    sha256 cellar: :any_skip_relocation, big_sur:  "51f6eb41f703fdf9ae0eee5b2273e8647c4a52514ea42409bbf81c4c4c10713a"
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
