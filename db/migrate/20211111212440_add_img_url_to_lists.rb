class AddImgUrlToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :img_url, :string
  end
end
