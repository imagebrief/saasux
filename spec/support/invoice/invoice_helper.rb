class InvoiceHelper
  def self.build_invoice(contact_uid=0)
    item = SaasuX::ServiceInvoiceItem.new      
    item.description = "Sample Item"
    item.account_uid = "577317"
    item.tax_code = "G1,G3"
    item.total_amount_incl_tax = "5000.0000"
    item.total_amount_excl_tax = "5000.0000"
    item.total_tax_amount = "0.0000"

    invoice_items = SaasuX::InvoiceItems.new
    invoice_items.service_invoice_items << item    

    terms = SaasuX::TradingTerms.new
    terms._type = "0"
    terms.interval = "0"
    terms.interval_type = "0"
    terms.type_enum = "Unspecified"
    terms.interval_type_enum = "Unspecified"

    invoice = SaasuX::Invoice.new
    invoice.uid = 0
    invoice.transaction_type = "S"
    invoice.date = "2012-07-01"
    invoice.contact_uid = contact_uid
    invoice.summary = "Test sale"
    invoice.tags = "sale"

    invoice.ccy = "USD"
    invoice.auto_populate_fx_rate = true

    invoice.due_or_expiry_date = "2013-07-01"
    invoice.layout = "S"
    invoice.status = "I"
    # invoice.invoice_type = "I" # not required to set?
    invoice.invoice_number = "<Auto Number>"
    invoice.requires_follow_up = false

    invoice.notes = "An internal note"
    invoice.external_notes = "A publicly visible note"

    invoice.invoice_items = invoice_items
    invoice.is_sent = false
    invoice.trading_terms = terms

    payment = SaasuX::InvoicePayment.new
    payment.invoice_payment_uid = "12345678"
    payment.ccy = "USD"
    
    invoice.payments = [payment]



    return invoice
  end
end