class Track < ActiveRecord::Base
  belongs_to :album

  validates :name, :album_id, :ord, presence: true
  validates :name, uniqueness: { scope: :album_id }
end
