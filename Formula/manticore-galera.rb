require 'hardware'

class ManticoreGalera < Formula
  desc "Galera Library (Manticore's fork)"
  homepage "https://github.com/manticoresoftware/galera"
  license "GPL-2.0"

  arch = Hardware::CPU.arch

  if arch.to_s == "x86_64" || arch.to_s == "amd64"
    version "3.37"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-galera-#{version}-Darwin-osx11.6-x86_64.tar.gz"
    sha256 "718ebe7ef7912f84d485dc108f4e8a30f9e933af8782e647abf411c382c11b99"
  else
    version "3.37"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-galera-#{version}-Darwin-osx11.6-arm64.tar.gz"
    sha256 "c1269a284672939d8c29299621581faff63ef094739b7680ac3116132552e33d"
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
