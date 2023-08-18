class CreateMorphImages < ActiveRecord::Migration[7.0]
  def change
    create_table :morph_images do |t|

      t.timestamps
    end
  end
end
