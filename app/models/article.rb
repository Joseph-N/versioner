class Article < ActiveRecord::Base
  versioned

  belongs_to :user
  belongs_to :organisation
  has_many :attachments, dependent: :destroy
  has_many :attachment_trackers, dependent: :destroy

  after_save :create_attachments_tracker

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |a| a[:image].blank? }

  validates_presence_of :user_id, :organisation_id, :title, :body


  private
  def create_attachments_tracker
    self.attachment_trackers.create(version_id: self.version, attachments: self.attachments.map(&:id))
  end
end
