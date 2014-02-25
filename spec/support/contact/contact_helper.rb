class ContactHelper
  def self.build_contact(contact_uid=0)
    contact = SaasuX::Contact.new
    contact.uid = contact_uid
    contact.salutation = "Mr."
    contact.given_name = "Bob"
    contact.family_name = "Smith"
    contact.organisation_name = "Organisation"
    contact.organisation_abn = "11 222 333 444"
    contact.organisation_position = "Position"
    contact.email = "name@address.com"
    contact.main_phone = "2222 3333"
    contact.mobile_phone = "1234534432"
    contact.contact_id = "contactID"
    contact.tags = "tag"

    contact.postal_address = AddressHelper.build_postal_address
    contact.other_address = nil

    contact.is_active = true
    contact.accept_direct_deposit = false
    contact.direct_deposit_account_name = "directDepositAccountName"
    contact.direct_deposit_bsb = "012345"
    contact.direct_deposit_account_number = "12345678"
    contact.accept_cheque = false
    contact.custom_field_1 = "customField1"
    contact.custom_field_2 = "customField2"
    contact.twitter_id = "@twitterid"
    contact.skype_id = "skypeid"

    return contact
  end
end