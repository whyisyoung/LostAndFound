class AddAttachmentPhotoToLostItems < ActiveRecord::Migration
  def self.up
    change_table :lost_items do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :lost_items, :photo
  end
end
