module SaasuX
  class UpdateInvoice
    include XML::Mapping
    text_node :email_to_contact, "@emailToContact", :default_value => "false"
    object_node :invoice, "invoice", :class => Invoice
  end
end