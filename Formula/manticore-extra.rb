require_relative 'manticore-extra-dev'
require_relative 'manticore_helper'

class ManticoreExtra < ManticoreExtraDev
  url "file://" + File.expand_path(__FILE__)
  version "0.6.4-230205-cdc5552" # Must be same as executor
  sha256 Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest

  depends_on "manticoresoftware/manticore-no-bottles/manticore-columnar-lib"
  depends_on "manticoresoftware/manticore-no-bottles/manticore-executor"
end
