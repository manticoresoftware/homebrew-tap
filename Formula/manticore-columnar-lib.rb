require_relative 'manticore-columnar-lib-dev'
require_relative 'manticore_helper'
require 'hardware'

class ManticoreColumnarLib < ManticoreColumnarLibDev
  arch = Hardware::CPU.arch
  fetched_info = ManticoreHelper.fetch_version_from_url(
    "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-columnar-lib-2.0.4-230306-5a49bd7-osx11.6-#{arch}.tar.gz"
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]
end
