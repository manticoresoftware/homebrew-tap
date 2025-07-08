class ManticoreLoad < Formula
    desc "Manticore Load Emulator"
    homepage "https://github.com/manticoresoftware/manticoresearch-load"
    license "MIT"
  
    version "1.19.0+25063014-1ff59652"
    url "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-load_#{version}.tar.gz"
    sha256 "3c760ecfeb7e374fb3b2d0bf7628feeccb18933b79e464fb719596c462b12c6c"
  
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