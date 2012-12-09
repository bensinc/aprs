class MainController < ApplicationController
  def index
  	@lat = 41.1241
  	@lon = -93.4242
  	@recent_packets = Packet.find(:all, :order => 'created_at desc', :limit => 25)
  	#@nearby_packets = Packet.geo_scope(:origin => [@lat, @lon], :conditions => "lat is not null", :limit => 25).order("distance asc")
  	@nearby_packets = Packet.find_by_sql("SELECT `packets`.*, 
 (ACOS(least(1,COS(0.7177509469194)*COS(-1.63055989104169)*COS(RADIANS(packets.lat))*COS(RADIANS(packets.lon))+
 COS(0.7177509469194)*SIN(-1.63055989104169)*COS(RADIANS(packets.lat))*SIN(RADIANS(packets.lon))+
 SIN(0.7177509469194)*SIN(RADIANS(packets.lat))))*3963.19)
 AS distance FROM `packets` where lat is not null order by distance asc limit 25")
  end

  def packet_info
	@lat = 41.1241
  	@lon = -93.4242
  	@packet = Packet.find(params[:id])
  	render :layout => false
  end

end
