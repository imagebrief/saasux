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
      insert_contact = SaasuX::InsertContact.new
      insert_contact.contact = contact
      tasks = SaasuX::Tasks.new
      tasks.insert_contact = insert_contact

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end
    
    def update_contact(contact)
      # build request
      update_contact = SaasuX::UpdateContact.new
      update_contact.contact = contact
      tasks = SaasuX::Tasks.new
      tasks.insert_contact = update_contact

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end

    # 
    # Deletes the contact with the specified contact_uid.
    #
    def delete_contact(contact_uid)
      # send request
      headers = build_headers
      query = build_query({:uid => contact_uid})
      options = {:headers => headers, :query => query}
      httpresp = self.class.delete("/Contact", options)
      response = SaasuX::ContactResponse.load_from_xml(REXML::Document.new(httpresp.body).root)
      return response
    end


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

    #
    # Returns a PDF invoice as the response.
    #
    # Options:
    #     - :template_uid   A custom template
    #
    def pdf_invoice(invoice_uid, options={})
      # send request
      headers = build_headers
      query = build_query({:uid => invoice_uid, :format => "pdf"})
      query[:template_uid] = options[:template_uid] if options[:template_uid] # custom template
      options = {:headers => headers, :query => query}
      httpresp = self.class.get("/Invoice", options)
      return httpresp.body
    end

    #
    # Delivers an invoice in PDF format using the Saasu platform.
    #
    # Options:
    #     - :template_uid   A custom template
    def email_pdf_invoice(invoice_uid, options={})
      # build request
      email_msg = SaasuX::EmailMessage.new
      email_msg.from      = options[:from] || "accounts@imagebrief.com"
      email_msg.to        = options[:to] || "dev@imagebrief.com"
      email_msg.cc        = options[:cc]
      email_msg.bcc       = options[:bcc]
      email_msg.subject   = options[:subject] || "Your invoice from Imagebrief"
      email_msg.body      = options[:body]

      email_req = SaasuX::EmailPdfInvoice.new
      email_req.invoice_uid = invoice_uid
      email_req.template_uid = options[:template_uid] if options[:template_uid]
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
      insert_invoice = SaasuX::InsertInvoice.new
      insert_invoice.email_to_contact = false
      insert_invoice.invoice = invoice
      tasks = SaasuX::Tasks.new
      tasks.insert_invoice = insert_invoice

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end


    def update_invoice(invoice)
      update_invoice = SaasuX::UpdateInvoice.new
      update_invoice.email_to_contact = false
      update_invoice.invoice = invoice
      tasks = SaasuX::Tasks.new
      tasks.update_invoice = update_invoice

      # send request
      headers = build_headers
      query = build_query
      xml_str = SaasuX::Formatter.new.write(tasks.save_to_xml)
      options = {:headers => headers, :query => query, :body => xml_str}
      httpresp = self.class.post("/tasks", options)
      response = SaasuX::TasksResponse.load_from_xml(REXML::Document.new(httpresp.body).root)

      return response
    end
    

    # 
    # Deletes the invoice with the specified invoice_uid.
    #
    def delete_invoice(invoice_uid)
      # send request
      headers = build_headers
      query = build_query({:uid => invoice_uid})
      options = {:headers => headers, :query => query}
      httpresp = self.class.delete("/Invoice", options)
      response = SaasuX::InvoiceResponse.load_from_xml(REXML::Document.new(httpresp.body).root)
      return response
    end

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