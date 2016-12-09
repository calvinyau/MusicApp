class AddBonusToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :bonus, :boolean, default: false, null: false
  end
end
