class AddPostImageToMicropost < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :post_image, :string
  end
end
