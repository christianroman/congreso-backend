class Member < ActiveRecord::Base

  attr_accessible :name, :district, :header, :state_id, :party, :email, :substitute, :image, :phones, :curul, :kind, :id_alt
  has_and_belongs_to_many :commissions
  belongs_to :state
  
  def self.nearby(latitude, longitude)
      lat = Float(latitude) rescue 0
      lon = Float(longitude) rescue 0

      find_by_sql("SELECT * FROM nearbymembers(#{lat}, #{lon})")
  end
  
end