class State < ActiveRecord::Base
  attr_accessible :id, :name, :division, :geom
  has_many :members
end
