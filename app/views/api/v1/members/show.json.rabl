object @member

attributes :id, :name, :district, :header, :party, :email, :substitute, :image, :phones, :curul, :kind, :id_alt

child :state do
	extends "api/v1/states/show"
end

child :commissions do
	attributes :id, :name
end