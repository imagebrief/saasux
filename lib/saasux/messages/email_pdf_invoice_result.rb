module SaasuX
  class EmailPdfInvoiceResult
    include XML::Mapping
    text_node :sent_to_contact, "@sentToContact", :default_value => ""
    object_node :errors, "errors", :class => Errors, :default_value => nil
  end
end