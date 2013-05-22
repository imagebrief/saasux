module SaasuX
  class ServiceInvoiceItem
    include XML::Mapping
    
    text_node :description, "description", :default_value => ""
    text_node :account_uid, "accountUid", :default_value => ""
    text_node :tax_code, "taxCode", :default_value => ""
    text_node :total_amount_incl_tax, "totalAmountInclTax", :default_value => ""
    text_node :total_amount_excl_tax, "totalAmountExclTax", :default_value => ""
    text_node :total_tax_amount, "totalTaxAmount", :default_value => ""
  end
end