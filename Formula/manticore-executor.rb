require_relative 'manticore-executor-dev'
require_relative 'manticore_helper'
require 'hardware'

class ManticoreExecutor < ManticoreExecutorDev
  arch = Hardware::CPU.arch
  fetched_info = ManticoreHelper.fetch_version_from_url(
    "https://repo.manticoresearch.com/repository/manticoresearch_macos/release/manticore-executor_0.6.4-230205-cdc5552_macos_#{arch}.tar.gz"
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]
end
