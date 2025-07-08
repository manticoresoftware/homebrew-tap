require 'hardware'

class ManticoreGalera < Formula
  desc "Galera Library (Manticore's fork)"
  homepage "https://github.com/manticoresoftware/galera"
  license "GPL-2.0"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "3.37"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-galera-#{version}-Darwin-osx11.6-x86_64.tar.gz"
    sha256 "3047eb0e87ff10f3d3904e37acd8e3a3c7994df75f16f6c4262d94704c157393"
  else
    version "3.37"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-galera-#{version}-Darwin-osx11.6-arm64.tar.gz"
    sha256 "97921556ad866e3644713aaaa0d328b5884fb3cd32564773aea2e01fe8203340"
  end

  def install
    arch = Hardware::CPU.arch
    (share/"manticore/modules").mkpath

    if arch == :x86_64
      # For x86_64 architecture
      share.install "usr/local/share/manticore/modules/libgalera_manticore.so" => "manticore/modules/libgalera_manticore.so"
    elsif arch == :arm64
      # For arm64 architecture
      share.install "opt/homebrew/share/manticore/modules/libgalera_manticore.so" => "manticore/modules/libgalera_manticore.so"
    end
  end

  test do
    dir = share
    output = shell_output("file #{dir}/manticore/modules/libgalera_manticore.so")
    assert_match "64-bit", output
  end
end
