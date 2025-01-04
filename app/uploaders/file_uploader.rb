require "shrine"

class FileUploader < Shrine
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :store_dimensions
end