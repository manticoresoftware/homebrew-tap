require 'open-uri'
require 'date'
require 'hardware'

module ManticoreHelper
  def self.fetch_version_and_url(base_url)
    content = URI.open(base_url).read
    arch = Hardware::CPU.arch
    pattern = /manticore-(\d+\.\d+\.\d+)-(\d+)-([\w]+)-osx11\.6-#{arch}-main\.tar\.gz/
    versions = []

    content.scan(pattern) do |match|
      semver = match[0]
      date = Date.strptime(match[1], '%y%m%d')
      hash_id = match[2]
      versions << { semver: semver, date: date, file: "manticore-#{semver}-#{match[1]}-#{hash_id}-osx11.6-#{arch}-main.tar.gz" }
    end

    versions.sort_by! { |v| [Gem::Version.new(v[:semver]), v[:date]] }.reverse!

    highest_version = "#{versions.first[:semver]}-#{versions.first[:date].strftime('%y%m%d')}-#{versions.first[:file].split('-')[3]}"
    highest_version_url = base_url + versions.first[:file]

    tmpdir = Dir.mktmpdir
    filepath = "#{tmpdir}/manticore-icudata.tar.gz"
    File.open(filepath, "wb") do |saved_file|
      open(highest_version_url, "rb") do |remote_file|
        saved_file.write(remote_file.read)
      end
    end

    {
      version: highest_version,
      file_url: "file://#{filepath}",
      sha256: Digest::SHA256.file(filepath).hexdigest
    }
  end
end
