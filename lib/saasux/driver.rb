require 'pp'
module SaasuX
  class Driver
    include HTTParty
    base_uri 'https://secure.saasu.com/webservices/rest/r1'

    attr_reader :config

    def initialize(config={})
      @config = config # {:query => {..}, :headers => {..}, :defaults => {..}}
    end


    ### Contacts

    def find_contact(contact_uid)
      # send request
      headers = build_headers
      query = build_query({:uid => contact_uid})
      options = {:headers => headers, :query => query}
      httpresp = self.class.get("/Contact", options)
      response = SaasuX::ContactResponse.load_from_xml(REXML::Document.new(httpresp.body).root)
      return response
    end

    def insert_contact(contact)
      # build request
      ic = SaasuX::InsertContact.new
      ic.contact = contact
      tasks = SaasuX::Tasks.new
      tasks.insert_contact = ic

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end
    
    # def update_contact(contact, options={})
    #   
    #   # .. PREPARE options etc
    #   
    #   httpresp = self.class.post("/updateContact", options)
    #   response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)
    #   
    #   if response.errors.nil? && !response.update_contact_result.nil?
    #     return response.update_contact_result
    #   else
    #     return nil
    #   end
    # 
    # end


    ### Invoices
    
    def find_invoice(invoice_uid)
      # send request
      headers = build_headers
      query = build_query({:uid => invoice_uid, :incpayments => "true"})
      options = {:headers => headers, :query => query}
      httpresp = self.class.get("/Invoice", options)
      response = SaasuX::InvoiceResponse.load_from_xml(REXML::Document.new(httpresp.body).root)
      return response
    end
    

    def pdf_invoice(invoice_uid)
      # send request
      headers = build_headers
      query = build_query({:uid => invoice_uid, :format => "pdf"})
      options = {:headers => headers, :query => query}
      httpresp = self.class.get("/Invoice", options)
      return httpresp.body
    end


    def email_pdf_invoice(invoice_uid, message={})
      # build request
      email_msg = SaasuX::EmailMessage.new
      email_msg.to = message[:to] || "dev@imagebrief.com"
      email_msg.from = message[:from] || "dev@imagebrief.com"
      email_msg.subject = message[:subject] || "Your invoice from Imagebrief"

      email_req = SaasuX::EmailPdfInvoice.new
      email_req.invoice_uid = invoice_uid
      # email_req.template_uid = XXX
      email_req.email_message = email_msg

      tasks = SaasuX::Tasks.new
      tasks.email_pdf_invoice = email_req

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end


    def insert_invoice(invoice)
      # build request
      ii = SaasuX::InsertInvoice.new
      ii.email_to_contact = false
      ii.invoice = invoice
      tasks = SaasuX::Tasks.new
      tasks.insert_invoice = ii

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end



    # def update_invoice(invoice, options={})
    # end
    # 
    # 

    protected
   
    def build_query(custom={})
      custom.merge!(@config[:query])
    end

    def build_headers(custom={})
      base_headers = @config[:headers] || {"Content-Type" => "application/xml"} # default value
      custom.merge!(base_headers)
    end
  end
end