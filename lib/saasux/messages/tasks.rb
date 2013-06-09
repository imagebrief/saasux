module SaasuX
  class Tasks
    include XML::Mapping
    choice_node :if,    'insertContact', :then, (object_node :insert_contact, "insertContact", :class => InsertContact),
                :elsif, 'updateContact', :then, (object_node :update_contact, "updateContact", :class => UpdateContact),
                :elsif, 'insertInvoice', :then, (object_node :insert_invoice, "insertInvoice", :class => InsertInvoice),
                :elsif, 'updateInvoice', :then, (object_node :update_invoice, "updateInvoice", :class => UpdateInvoice),
								:elsif, 'emailPdfInvoice', :then, (object_node :email_pdf_invoice, "emailPdfInvoice", :class => EmailPdfInvoice)
  end
end