class CreateAttachmentTrackers < ActiveRecord::Migration
  def change
    create_table :attachment_trackers do |t|
      t.integer :version_id
      t.string :attachments, array: true, default: []
      t.references :article, index: true

      t.timestamps
    end
  end
end
