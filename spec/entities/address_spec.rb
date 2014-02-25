require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SaasuX" do
  describe "Address" do
    
    before do
      @address = SaasuX::Address.new
      @address.street = "1 Test St"
      @address.city = "Sydney"
      @address.state = "NSW"
      @address.postcode = "1234"
      @address.country = "Australia"
    end
    
    it "should have the required fields" do
      [:street, :city, :state, :postcode, :country].each do |field|
        expect(@address.methods).to include(field)
      end
    end

    
    it "should serialize" do
      xml_str = String.new
      xml_obj = @address.save_to_xml
      xml_obj.write(xml_str,2)
      # puts xml_str
      
      # test xml string
      expect(xml_str).to_not be_nil
      expect(xml_str).to_not be_empty
      expect(xml_str).to match(/<address>/)

      # test content of xml string
      expect(xml_str).to match(/<street>(.*?)/)
      expect(xml_str).to match(/<city>(.*?)/)
      expect(xml_str).to match(/<state>(.*?)/)
      expect(xml_str).to match(/<postCode>(.*?)/)
      expect(xml_str).to match(/<country>(.*?)/)
    end

    
    it "should deserialize" do
      filename = File.join(File.dirname(__FILE__), "../xml", "address.xml")
      address = SaasuX::Address.load_from_file(filename)
      
      # test the object graph
      expect(address).to_not be_nil
      expect(address).to be_an_instance_of SaasuX::Address

      expect(address.street).to_not be_empty
      expect(address.city).to_not be_empty
      expect(address.state).to_not be_empty
      expect(address.postcode).to_not be_empty
      expect(address.country).to_not be_empty      
    end
    
  end
end