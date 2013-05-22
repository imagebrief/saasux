module SaasuX
  class EmailPdfInvoice
    include XML::Mapping        

    text_node :invoice_uid, "invoiceUid", :default_value => ""
    text_node :template_uid, "templateUid", :default_value => ""
    object_node :email_message, "emailMessage", :class => EmailMessage
  end
end