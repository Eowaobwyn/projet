class Town < ActiveRecord::Base
  before_validation :set_geocode
  validates :name, :latitude, :longitude, presence: true

 def get_weather
  ForecastIO.forecast(latitude: self.latitude, longitude: self.longitude).currently
 end
 
 private  
  def set_geocode 
    towns = Nominatim.search.city(self.name).limit(1).address_details(true)
    if towns && towns.first
      current_town = towns.first
      self.zipcode = current_town.address.postcode
      self.latitude = current_town.lat
      self.longitude = current_town.lon
    end
  end
end
