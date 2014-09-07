class AttachmentTracker < ActiveRecord::Base
  belongs_to :article

  validates_presence_of :version_id, :attachments
end
