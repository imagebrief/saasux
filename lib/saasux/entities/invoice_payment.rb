module SaasuX
  class InvoicePayment
    include XML::Mapping
    
    text_node :invoice_payment_uid, "invoicePaymentUid", :default_value => ""
    text_node :payment_date, "paymentDate", :default_value => ""

    text_node :ccy, "ccy", :default_value => ""
    text_node :auto_populate_fx_rate, "autoPopulateFxRate", :default_value => ""
    text_node :fc_to_bc_fx_rate, "fcToBcFxRate", :default_value => ""

    text_node :notes, "notes", :default_value => ""
    text_node :reference, "reference", :default_value => ""
    text_node :summary, "summary", :default_value => ""

    text_node :bank_account_uid, "bankAccountUid", :default_value => ""
    text_node :payment_account_uid, "paymentAccountUid", :default_value => ""
    text_node :date_cleared, "dateCleared", :default_value => ""
    text_node :fee, "fee", :default_value => ""

    # array_node :invoice_payment_items, "invoicePaymentItems", "invoicePaymentItem", :class => SaasuX::InvoicePaymentItems, :default_value => nil
    
  end
end