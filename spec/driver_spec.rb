require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# A hacky class to persist various bits of state across tests
class TestState
  attr_accessor :contact_uid
  attr_accessor :invoice_uid
end

describe "SaasuX" do
  describe "Driver" do

    subject { uid }

    before(:all) do
      saasu_config = RSpec.configuration.saasu_config
      @driver = SaasuX::Driver.new(saasu_config)
      @test_state = TestState.new
    end

    ##
    ## Driver
    ##
 
    it "should be configured" do
      expect(@driver).to_not be_nil
      expect(@driver).to be_an_instance_of SaasuX::Driver

      expect(@driver.config).to_not be_nil
      expect(@driver.config).to include(:query)
      expect(@driver.config[:query]).to include(:wsaccesskey)
      expect(@driver.config[:query]).to include(:fileuid)
    end


    ##
    ## Contacts
    ##

    describe "for contacts" do
      
      it "should insert a new contact" do
        VCR.use_cassette('insert_contact') do
          c = ContactHelper.build_contact
          resp = @driver.insert_contact(c)

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::TasksResponse
          expect(resp.insert_contact_result).to_not be_nil
          expect(resp.errors).to be_nil
          
          # InsertContactResult
          expect(resp.insert_contact_result.inserted_entity_uid).to_not be_nil

          # Persist contact_uid
          @test_state.contact_uid = resp.insert_contact_result.inserted_entity_uid
        end
      end

      it "should find a contact that exists" do
        contact_uid = @test_state.contact_uid
        expect(contact_uid).to_not be_nil # pre-condition

        VCR.use_cassette('find_contact_that_exists') do
          resp = @driver.find_contact(contact_uid)

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::ContactResponse

          # Errors
          expect(resp.errors).to be_nil

          # Contact
          expect(resp.contact).to_not be_nil
          expect(resp.contact).to be_an_instance_of SaasuX::Contact
          expect(resp.contact.uid).to match(contact_uid)
        end
      end

      it "should not find a contact that does not exist" do
        VCR.use_cassette('find_contact_that_does_not_exist') do
          resp = @driver.find_contact("9999999")

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::ContactResponse
          
          # Contact
          expect(resp.contact).to be_nil

          # Errors
          expect(resp.errors).to_not be_nil
          expect(resp.errors).to be_an_instance_of SaasuX::Errors
          expect(resp.errors.error).to be_an_instance_of SaasuX::Error
          expect(resp.errors.error.type).to match('RecordNotFoundException')
        end
      end

      it "should delete a contact" do
        contact_uid = @test_state.contact_uid
        expect(contact_uid).to_not be_nil # pre-condition

        VCR.use_cassette('delete_contact_that_exists') do
          resp = @driver.delete_contact(contact_uid)
          
          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::ContactResponse

          # Errors
          expect(resp.errors).to be_nil

          # DeleteResult
          expect(resp.delete_result).to_not be_nil
          expect(resp.delete_result.uid).to_not be_nil
          expect(resp.delete_result.uid).to match(contact_uid)
        end        
      end

      it "should not delete a contact that does not exist" do
        VCR.use_cassette('delete_contact_that_does_not_exist') do
          resp = @driver.delete_contact("9999999")

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::ContactResponse

          # Errors
          # interestingly, Saasu API accepts a call to delete a non-existent contact_uid
          # and responds with a 200 OK. This is not strictly what you would expect!
          expect(resp.errors).to be_nil
        end
      end

    end


    ##
    ## Invoices
    ##
    
    describe "for invoices" do

      it "should insert a new invoice" do
        VCR.use_cassette('insert_invoice') do
          # create contact ...
          c = ContactHelper.build_contact
          resp = @driver.insert_contact(c)

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::TasksResponse
          expect(resp.errors).to be_nil
          
          expect(resp.insert_contact_result).to_not be_nil
          expect(resp.insert_contact_result.inserted_entity_uid).to_not be_nil

          # Persist contact_uid
          contact_uid = resp.insert_contact_result.inserted_entity_uid
          @test_state.contact_uid = contact_uid

          # create invoice ...
          invoice = InvoiceHelper.build_invoice(contact_uid) # build sample for contact
          resp = @driver.insert_invoice(invoice)
          
          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::TasksResponse
          expect(resp.errors).to be_nil

          # InsertInvoiceResult
          expect(resp.insert_invoice_result).to_not be_nil
          expect(resp.insert_invoice_result).to be_an_instance_of SaasuX::InsertInvoiceResult
          expect(resp.insert_invoice_result.inserted_entity_uid).to_not be_nil

          # Persist invoice_uid
          @test_state.invoice_uid = resp.insert_invoice_result.inserted_entity_uid
        end
      end

      it "should find an invoice that exists" do
        invoice_uid = @test_state.invoice_uid
        expect(invoice_uid).to_not be_nil # pre-condition

        VCR.use_cassette('find_invoice_that_exists') do
          resp = @driver.find_invoice(invoice_uid)

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::InvoiceResponse
          expect(resp.invoice).to_not be_nil
          expect(resp.invoice).to be_an_instance_of SaasuX::Invoice
          expect(resp.invoice.uid).to match(invoice_uid)

          # Errors
          expect(resp.errors).to be_nil          
        end
      end

      it "should not find an invoice that does not exist" do
        VCR.use_cassette('find_invoice_that_does_not_exist') do
          resp = @driver.find_invoice("9999999")

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::InvoiceResponse
          
          # Invoice
          expect(resp.invoice).to be_nil

          # Errors
          expect(resp.errors).to_not be_nil
          expect(resp.errors).to be_an_instance_of SaasuX::Errors
          expect(resp.errors.error).to be_an_instance_of SaasuX::Error
          expect(resp.errors.error.type).to match('RecordNotFoundException')
        end
      end

      it "should delete an invoice that exists" do
        invoice_uid = @test_state.invoice_uid
        expect(invoice_uid).to_not be_nil # pre-condition

        VCR.use_cassette('delete_invoice_that_exists') do
          resp = @driver.delete_invoice(invoice_uid)

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::InvoiceResponse

          # Errors
          expect(resp.errors).to be_nil

          # DeleteResult
          expect(resp.delete_result).to_not be_nil
          expect(resp.delete_result.uid).to_not be_nil
          expect(resp.delete_result.uid).to match(invoice_uid)          
        end
      end

      it "should not delete an invoice that does not exist" do
        VCR.use_cassette('delete_invoice_that_does_not_exist') do
          resp = @driver.delete_invoice("9999999")

          # Response
          expect(resp).to_not be_nil
          expect(resp).to be_an_instance_of SaasuX::InvoiceResponse
          
          # Errors
          expect(resp.errors).to_not be_nil
          expect(resp.errors).to be_an_instance_of SaasuX::Errors
          expect(resp.errors.error).to be_an_instance_of SaasuX::Error
          expect(resp.errors.error.type).to match('RecordNotFoundException')
        end
      end
    
    end

  end

end