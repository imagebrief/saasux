require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SaasuX" do
  describe "Contact" do
    
    before do
      @contact = ContactHelper.build_contact
    end
    
    
    it "should serialize" do
      
      xml_str = String.new
      xml_obj = @contact.save_to_xml
      xml_obj.write(xml_str,2)
      # puts xml_str

      # test xml string
      expect(xml_str).to_not be_nil
      expect(xml_str).to_not be_empty
      expect(xml_str).to match(/<contact (.*?)/)

      # test content of xml string
      expect(xml_str).to match(/<givenName>(.*?)/)
      expect(xml_str).to match(/<familyName>(.*?)/)
      expect(xml_str).to match(/<email>(.*?)/)
      expect(xml_str).to match(/<contactID>(.*?)/)
      expect(xml_str).to match(/<postalAddress>(.*?)/)
    end
    
    
    it "should deserialize" do  

      filename = File.join(File.dirname(__FILE__), "../xml", "contact.xml")
      contact = SaasuX::Contact.load_from_file(filename)
      
      # test the object graph
      expect(contact).to_not be_nil
      expect(contact).to be_an_instance_of SaasuX::Contact
      
      expect(contact.given_name).to_not be_empty
      expect(contact.family_name).to_not be_empty
      expect(contact.email).to_not be_empty
      expect(contact.contact_id).to_not be_empty
      
      expect(contact.postal_address).to_not be_nil
      expect(contact.postal_address).to be_an_instance_of SaasuX::Address
      expect(contact.postal_address).to_not be_empty

      expect(contact.other_address).to_not be_nil
      expect(contact.other_address).to be_an_instance_of SaasuX::Address
      expect(contact.other_address).to be_empty
    end
    
  end
end