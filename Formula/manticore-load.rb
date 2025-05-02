class ManticoreLoad < Formula
    desc "Manticore Load Emulator"
    homepage "https://github.com/manticoresoftware/manticoresearch-load"
    license "MIT"
  
    version "1.18.2+25050118-8537968a"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-load_#{version}.tar.gz"
    sha256 "7d12a1ed086e28c9f4809114f2ece2e7392fd47085a1a496aab67344247c65c6"
  
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