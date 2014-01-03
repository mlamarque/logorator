class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :abbreviation

      t.timestamps
    end
  end
end
