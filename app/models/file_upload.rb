require "shrine"
require "securerandom"
class FileUpload < ApplicationRecord
  # include Shrine::Attachment(:file_uploaded)

  belongs_to :user

  before_create :generate_shared_link

  has_one_attached :file

  private

  def generate_shared_link
    self.shared_link = SecureRandom.hex(8)
  end
end
