module SaasuX
  class TasksResponse
    include XML::Mapping
    choice_node :if,    'insertContactResult', :then, (object_node :insert_contact_result, "insertContactResult", :class => InsertContactResult),
                :elsif, 'updateContactResult', :then, (object_node :update_contact_result, "updateContactResult", :class => UpdateContactResult),
                :elsif, 'insertInvoiceResult', :then, (object_node :insert_invoice_result, "insertInvoiceResult", :class => InsertInvoiceResult),
                :elsif, 'updateInvoiceResult', :then, (object_node :update_invoice_result, "updateInvoiceResult", :class => UpdateInvoiceResult),
                :elsif, 'emailPdfInvoiceResult', :then, (object_node :email_pdf_invoice_result, "emailPdfInvoiceResult", :class => EmailPdfInvoiceResult),
                :elsif, 'errors', :then, (object_node :errors, "errors", :class => Errors)
  end
end