module SaasuX
  class InvoiceResponse
    include XML::Mapping

    choice_node :if,    'errors',         :then, (object_node :errors, "errors", :class => Errors, :default_value => nil),
                :elsif, 'invoice',        :then, (object_node :invoice, "invoice", :class => Invoice, :default_value => nil),
                :elsif, 'deleteResult',  :then, (object_node :delete_result, "deleteResult", :class => DeleteInvoiceResult, :default_value => nil)

  end
end