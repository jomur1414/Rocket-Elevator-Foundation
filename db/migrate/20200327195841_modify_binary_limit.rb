class ModifyBinaryLimit < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :file_attachment, :binary, :limit => 16.megabyte
    add_column :leads, :file_name, :string
  end
end
