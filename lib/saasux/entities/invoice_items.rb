module SaasuX
  class InvoiceItems
    include XML::Mapping
    
    choice_node :if,    'serviceInvoiceItem', :then, (array_node :service_invoice_items, "serviceInvoiceItem", :class => ServiceInvoiceItem, :default_value => []),
                :elsif, 'itemInvoiceItem',    :then, (array_node :item_invoice_items, "itemInvoiceItem", :class => ItemInvoiceItem, :default_value => [])
                
  end
end