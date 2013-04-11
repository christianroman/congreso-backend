class Commission < ActiveRecord::Base
  attr_accessible :id, :name
  has_and_belongs_to_many :members
end
