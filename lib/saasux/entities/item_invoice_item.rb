module SaasuX
  class ItemInvoiceItem
    include XML::Mapping
    
    text_node :todo, "TODO", :default_value => ""
  end
end