class Attachment < ActiveRecord::Base
  versioned

  belongs_to :article

  has_attached_file :image,
                    :keep_old_files => true,
                    :styles => { :medium => "400x400#",:thumb => "100x100#" },
                    :url => "/attachments/articles/:article_id/:id/version_:version/:style/:basename.:extension",
                    :path => ":rails_root/public/attachments/articles/:article_id/:id/version_:version/:style/:basename.:extension"

  validates_attachment 	:image,
                        :presence => true,
                        :content_type => { :content_type => /\Aimage\/.*\Z/ },
                        :size => { :less_than => 2.megabytes }

  Paperclip.interpolates :article_id do |attachment, style|
    attachment.instance.article_id.to_s
  end

  Paperclip.interpolates :version do |attachment, style|
    attachment.instance.version.to_s
  end

  Paperclip.registered_attachments_styles_path = "#{Rails.root}/public/attachments/paperclip_attachments.yml"
end
