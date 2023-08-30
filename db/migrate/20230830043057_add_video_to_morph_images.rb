class AddVideoToMorphImages < ActiveRecord::Migration[7.0]
  def change
    add_column :morph_images, :video, :string
  end
end
