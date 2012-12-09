class Packet < ActiveRecord::Base
  # attr_accessible :title, :body
    acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lon

  def name
  	return self.from unless self.object_name
  	return self.object_name
  end

  def distance(lat, lon)
	Geokit::LatLng.new(lat, lon).distance_to(Geokit::LatLng.new(self.lat, self.lon), :units => :miles)
  end

  def heading(lat, lon)
	Geokit::LatLng.new(lat, lon).heading_to(Geokit::LatLng.new(self.lat, self.lon))
  end

  def path
  	return self.raw.split(':')[0].split('>')[1]
  end

end
