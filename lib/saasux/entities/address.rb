module SaasuX
  class Address
    include XML::Mapping
  
    text_node :street, "street", :default_value => ""
    text_node :city, "city", :default_value => ""
    text_node :state, "state", :default_value => ""
    text_node :postcode, "postCode", :default_value => ""
    text_node :country, "country", :default_value => ""
    
    def empty?
      street.empty? && city.empty? && state.empty? && postcode.empty? && country.empty?
    end

  end
    
end