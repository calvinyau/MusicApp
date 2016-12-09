class Album < ActiveRecord::Base
  has_many :tracks, dependent: :destroy
  belongs_to :band

  validates :name, :band_id, :year, :setting, presence: true
  validates :name, uniqueness: {scope: :band_id}

end
