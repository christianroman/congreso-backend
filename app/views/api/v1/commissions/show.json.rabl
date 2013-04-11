object @commission

attributes :id, :name

child :members do
	attributes :id, :name, :district, :header, :party, :email, :substitute, :image, :phones, :curul, :kind, :id_alt

	child :state do
		extends "api/v1/states/show"
	end
end