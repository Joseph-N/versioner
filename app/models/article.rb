class Article < ActiveRecord::Base
  versioned

  belongs_to :user
  belongs_to :organisation
  has_many :attachments, dependent: :destroy
  has_many :attachment_trackers, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |a| a[:image].blank? }

  validates_presence_of :user_id, :organisation_id, :title, :body
end
