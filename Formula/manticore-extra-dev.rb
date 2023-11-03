require "digest"
require_relative 'manticore_helper'

class ManticoreExtraDev < Formula
  desc "Manticore meta package to install manticore-executor and manticore-columnar-lib dependencies"
  homepage "https://manticoresearch.com"
  url "file://" + File.expand_path(__FILE__)
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest

  base_url = 'https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/'
  highest_version, highest_version_url = ManticoreHelper.find_version_and_url(
    'manticore-executor',
    base_url,
    /(manticore-executor_)(\d+\.\d+\.\d+)(\-)(\d+\-)([\w]+)(_macos_amd64\.tar\.gz)/
  )
  version "#{highest_version}"

  depends_on "manticoresoftware/tap/manticore-columnar-lib-dev"
  depends_on "manticoresoftware/tap/manticore-executor-dev"

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
