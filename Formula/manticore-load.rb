class ManticoreLoad < Formula
    desc "Manticore Load Emulator"
    homepage "https://github.com/manticoresoftware/manticoresearch-load"
    license "MIT"
  
    version "1.24.0+25122422-e5db1c82"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-load_#{version}.tar.gz"
    sha256 "cdcc2d0bd2f701e88331459fb038f8ab4fb3e3f673d6ed60eafc0f57681913a6"
  
    def install
      # Install the binary
      bin.install "manticore-load"
  
      # Create target directory
      (share/"manticore/modules/manticore-load").mkpath
  
      # Install all files from src directory
      Dir["src/*"].each do |file|
        # Use cp_r instead of install to preserve directory structure
        cp_r file, share/"manticore/modules/manticore-load"
      end
    end
  
    test do
      assert_predicate share/"manticore/modules/manticore-load/configuration.php", :exist?
      assert_predicate bin/"manticore-load", :exist?
    end
  end