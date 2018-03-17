class Town < ActiveRecord::Base
  before_validation :set_geocode
  validates :name, :latitude, :longitude, presence: true

  
 private  
  def set_geocode 
    towns = Nominatim.search.city(self.name).limit(1)
    if towns && towns.first
      current_town = towns.first
      #self.zipcode = current_town.zipcode
      self.latitude = current_town.lat
      self.longitude = current_town.lon
    end
  end
end
