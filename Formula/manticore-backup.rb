require_relative 'manticore-backup-dev'
require_relative 'manticore_helper'

class ManticoreBackup < ManticoreBackupDev
  fetched_info = ManticoreHelper.fetch_version_from_url(
    "https://repo.manticoresearch.com/repository/manticoresearch_macos/dev/manticore-backup_1.0.5-23050204-4c13704.tar.gz"
  )

  version fetched_info[:version]
  url fetched_info[:file_url]
  sha256 fetched_info[:sha256]
end
