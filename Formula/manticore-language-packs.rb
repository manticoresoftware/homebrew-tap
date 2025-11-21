class ManticoreLanguagePacks < Formula
  desc "Download and install Manticore morphology packs"
  homepage "https://manticoresearch.com/"
  url "https://manticoresearch.com"
  version "0.9.9"

  def install
    manticore_share = share/"manticore"
    manticore_share.mkpath

    # Download and unpack morphology .pak files
    %w[de en ru].each do |lang|
      archive = "#{lang}.pak.tgz"
      system "curl", "-sSL",
             "https://repo.manticoresearch.com/repository/morphology/#{lang}.pak.tgz",
             "-o", archive
      system "tar", "xzf", archive, "-C", manticore_share.to_s
    end

    # Directory for jieba dict files (sibling to the .pak files)
    jieba_dir = manticore_share/"jieba"
    jieba_dir.mkpath

    # Download jieba dict files
    %w[hmm_model idf stop_words user.dict].each do |name|
      system "curl", "-sSL",
             "https://raw.githubusercontent.com/manticoresoftware/cppjieba/master/dict/#{name}.utf8",
             "-o", (jieba_dir/"#{name}.utf8")
    end

    system "curl", "-sSL",
           "https://raw.githubusercontent.com/manticoresoftware/jieba/refs/heads/master/extra_dict/dict.txt.big",
           "-o", (jieba_dir/"jieba.dict.utf8")
  end
end