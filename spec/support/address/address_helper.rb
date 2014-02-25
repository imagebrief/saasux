class AddressHelper
  def self.build_home_address
	  @address = SaasuX::Address.new
    @address.street = "1 Test St"
    @address.city = "Sydney"
    @address.state = "NSW"
    @address.postcode = "1234"
    @address.country = "Australia"
	end

	def self.build_postal_address
		@address = SaasuX::Address.new
    @address.street = "Locked Bag L1001"
    @address.city = "Sydney"
    @address.state = "NSW"
    @address.postcode = "2000"
    @address.country = "Australia"
	end
end