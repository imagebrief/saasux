# Note: load order is important here. For requests (outer -> inner),
# and for responses (inner -> outer)

###
### Request
###
require "saasux/messages/insert_contact"
require "saasux/messages/update_contact"
require "saasux/messages/insert_invoice"

require "saasux/messages/email_pdf_invoice"

require "saasux/messages/tasks"

###
### Response
###

require "saasux/messages/error"
require "saasux/messages/errors"

require "saasux/messages/insert_invoice_result"
require "saasux/messages/email_pdf_invoice_result"

require "saasux/messages/insert_contact_result"
require "saasux/messages/update_contact_result"

require "saasux/messages/delete_result"

require "saasux/messages/contact_response"
require "saasux/messages/invoice_response"

require "saasux/messages/tasks_response"
