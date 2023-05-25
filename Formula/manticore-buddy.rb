require_relative 'manticore-buddy-dev'
require_relative 'manticore_helper'

class ManticoreBuddy < ManticoreBuddyDev
  fetched_info = ManticoreHelper.fetch_version_from_url(
    "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-buddy_1.0.3_23050204.80bf425.tar.gz"
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]
end
