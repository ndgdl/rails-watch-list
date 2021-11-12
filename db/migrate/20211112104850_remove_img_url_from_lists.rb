class RemoveImgUrlFromLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :lists, :img_url, :string
  end
end
