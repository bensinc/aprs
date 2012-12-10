class MainController < ApplicationController
  def index
  	@lat = 41.1241
  	@lon = -93.4242
  	@recent_packets = Packet.find(:all, :order => 'created_at desc', :limit => 25)
  	@nearby_packets = Packet.find_by_sql("SELECT `packets`.*, 
 (ACOS(least(1,COS(0.7177509469194)*COS(-1.63055989104169)*COS(RADIANS(packets.lat))*COS(RADIANS(packets.lon))+
 COS(0.7177509469194)*SIN(-1.63055989104169)*COS(RADIANS(packets.lat))*SIN(RADIANS(packets.lon))+
 SIN(0.7177509469194)*SIN(RADIANS(packets.lat))))*3963.19)
 AS distance FROM `packets` where lat is not null order by distance asc limit 25")

    
      s = Setting.find_by_key('tracking')

      if s
          @packet = Packet.find(:first, :conditions => ['`from` = ? or object_name = ?', s.value, s.value])
      end

  end

  def nearby
    @lat = 41.1241
    @lon = -93.4242
    @nearby_packets = Packet.find_by_sql("SELECT `packets`.*, 
 (ACOS(least(1,COS(0.7177509469194)*COS(-1.63055989104169)*COS(RADIANS(packets.lat))*COS(RADIANS(packets.lon))+
 COS(0.7177509469194)*SIN(-1.63055989104169)*COS(RADIANS(packets.lat))*SIN(RADIANS(packets.lon))+
 SIN(0.7177509469194)*SIN(RADIANS(packets.lat))))*3963.19)
 AS distance FROM `packets` where lat is not null order by distance asc limit 25")
    render :partial => 'list', :locals => {:packets => @nearby_packets}
  end

  def recent
    @lat = 41.1241
    @lon = -93.4242
    @recent_packets = Packet.find(:all, :conditions => ["id > ?", params[:id]], :order => 'created_at desc', :limit => 25)
    @last_recent_id = params[:id]
    render :layout => false
  end


  def tracked

     @lat = 41.1241
    @lon = -93.4242

    packet = Packet.find(:first, :conditions => ['`from` = ? or object_name = ?', params[:name], params[:name]])
    if packet
      render :partial => 'tracker', :locals => {:packet => packet}
    else
      render :text => ''
    end
  end


  def packet_info
	   @lat = 41.1241
  	@lon = -93.4242
  	@packet = Packet.find(params[:id])
  	render :layout => false
  end

  def track

     @lat = 41.1241
    @lon = -93.4242

    s = Setting.find(:first, :conditions => "`key` = 'tracking'")
    s = Setting.new unless s
    s.key = 'tracking'
    s.value = params[:name]
    s.save

    packet = Packet.find(:first, :conditions => ['`from` = ? or object_name = ?', params[:name], params[:name]])
    if packet
      render :partial => 'tracker', :locals => {:packet => packet}
    else
      render :text => ''
    end
  end

end
