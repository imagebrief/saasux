require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SaasuX" do
  describe "Invoice" do
    
    before do
      @invoice = InvoiceHelper.build_invoice("123456")
    end
    
    it "should serialize" do      
      xml_str = SaasuX::Formatter.new.write(@invoice.save_to_xml)

      # test xml string
      expect(xml_str).to_not be_nil
      expect(xml_str).to_not be_empty
      expect(xml_str).to match(/<invoice (.*?)/)
      
      # test content of xml string
      expect(xml_str).to match(/<transactionType>(.*?)/)
      expect(xml_str).to match(/<contactUid>(.*?)/)
      expect(xml_str).to match(/<date>(.*?)/)
      expect(xml_str).to match(/<isSent>(.*?)/)
      expect(xml_str).to match(/<invoiceItems>(.*?)/)
      expect(xml_str).to match(/<payments>(.*?)/)
    end
    
    
    it "should deserialize" do  
      filename = File.join(File.dirname(__FILE__), "../xml", "invoice.xml")
      invoice = SaasuX::Invoice.load_from_file(filename)
      
      # invoice
      expect(invoice).to_not be_nil
      expect(invoice).to be_an_instance_of SaasuX::Invoice
      
      expect(invoice.transaction_type).to_not be_empty
      expect(invoice.contact_uid).to_not be_empty
      expect(invoice.date).to_not be_empty
      expect(invoice.is_sent).to_not be_empty
      
      expect(invoice.invoice_items).to_not be_nil
      expect(invoice.invoice_items).to be_an_instance_of SaasuX::InvoiceItems

      # invoice items
      expect(invoice.invoice_items.service_invoice_items).to_not be_nil
      expect(invoice.invoice_items.service_invoice_items).to be_an_instance_of Array
      expect(invoice.invoice_items.service_invoice_items.first).to_not be_nil
      expect(invoice.invoice_items.service_invoice_items.first).to be_an_instance_of SaasuX::ServiceInvoiceItem

      expect(invoice.invoice_items.item_invoice_items).to be_nil

      # trading terms
      expect(invoice.trading_terms).to_not be_nil
      expect(invoice.trading_terms).to be_an_instance_of SaasuX::TradingTerms

      # payments
      expect(invoice.payments).to_not be_nil
      expect(invoice.payments).to be_an_instance_of Array
      expect(invoice.payments).to_not be_empty
      expect(invoice.payments.first).to be_an_instance_of SaasuX::InvoicePayment

    end
    
  end
end