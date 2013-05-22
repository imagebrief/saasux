module SaasuX
  class InvoiceResponse
    include XML::Mapping

    object_node :errors, "errors", :class => Errors, :default_value => nil
    object_node :invoice, "invoice", :class => Invoice, :default_value => nil
  end
end