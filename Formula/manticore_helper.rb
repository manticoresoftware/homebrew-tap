require 'open-uri'
require 'date'
require "tmpdir"
require "digest"

module ManticoreHelper
  def self.fetch_version_and_url(formula_name, base_url, pattern)
    highest_version, highest_version_url = self.find_version_and_url(formula_name, base_url, pattern)
    filepath, sha256 = download_file(formula_name, highest_version_url)

    {
      version: highest_version,
      file_url: "file://#{filepath}",
      sha256: sha256
    }
  end

  def self.find_version_and_url(formula_name, base_url, pattern)
    puts "Attempting to open URL: #{base_url}"

    content = URI.open(base_url).read

    puts "Content fetched from the URL:\n#{content[0..500]}..."

    # Let's check if the pattern is correct and can be used for scanning
    puts "Using pattern: #{pattern}"

    versions = []

    content.scan(pattern) do |match|
      # Output each match to see if we're actually matching anything
      puts "Matched: #{match.inspect}"

      semver = match[1]
      separator = match[2]
      date = match[3]
      hash_id = match[4]

      # Check each component to see if they're extracted correctly
      puts "semver: #{semver}"
      puts "separator: #{separator}"
      puts "date: #{date}"
      puts "hash_id: #{hash_id}"

      versions << { semver: Gem::Version.new(semver), separator: separator, date: date, hash_id: hash_id, file: "#{match[0]}#{semver}#{separator}#{date}#{hash_id}#{match[5]}" }
    end

    puts "Found versions: #{versions}"

    if versions.empty?
      raise "Could not find versions by using provided URL and pattern"
    end

    versions.sort_by! { |v| [v[:semver], v[:date]] }.reverse!

    highest_version = "#{versions.first[:semver]}#{versions.first[:separator]}#{versions.first[:date]}#{versions.first[:hash_id]}"
    highest_version_url = base_url + versions.first[:file]

    puts "Highest version detected: #{highest_version}"
    puts "URL for the highest version: #{highest_version_url}"

    if highest_version.nil? || highest_version_url.nil?
      raise "Could not find version or URL for '#{formula_name}' with the given pattern: #{pattern}"
    end

    [highest_version, highest_version_url]
  end

  def self.fetch_version_from_url(url)
    version = url.match(/(?<=-)[\d\w\._]+(?=-|\_)/).to_s
    formula_name = url.match(/(?<=release\/)[\w-]+(?=-)/).to_s
    filepath, sha256 = download_file(formula_name, url)

    {
      version: version,
      file_url: "file://#{filepath}",
      sha256: sha256
    }
  end

  def self.download_file(formula_name, url)
    tmpdir = Dir.mktmpdir
    filepath = "#{tmpdir}/#{formula_name}.tar.gz"
    File.open(filepath, "wb") do |saved_file|
      open(url, "rb") do |remote_file|
        saved_file.write(remote_file.read)
      end
    end

    [filepath, Digest::SHA256.file(filepath).hexdigest]
  end
end