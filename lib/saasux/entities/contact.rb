module SaasuX
  class Contact
    include XML::Mapping
    
    text_node :uid, "@uid", :default_value => ""
    text_node :salutation, "salutation", :default_value => ""
    text_node :given_name, "givenName", :default_value => ""
    text_node :family_name, "familyName", :default_value => ""
    text_node :organisation_name, "organisationName", :default_value => ""
    text_node :organisation_abn, "organisationAbn", :default_value => ""
    text_node :organisation_position, "organisationPosition", :default_value => ""
    text_node :email, "email", :default_value => ""
    text_node :main_phone, "mainPhone", :default_value => ""
    text_node :mobile_phone, "mobilePhone", :default_value => ""
    text_node :contact_id, "contactID", :default_value => ""
    text_node :tags, "tags", :default_value => ""
    
    object_node :postal_address, "postalAddress", :class => Address, :default_value => nil
    object_node :other_address, "otherAddress", :class => Address, :default_value => nil
    
    text_node :is_active, "isActive", :default_value => ""
    text_node :accept_direct_deposit, "acceptDirectDeposit", :default_value => ""
    text_node :direct_deposit_account_name, "directDepositAccountName", :default_value => ""
    text_node :direct_deposit_bsb, "directDepositBsb", :default_value => ""
    text_node :direct_deposit_account_number, "directDepositAccountNumber", :default_value => ""
    text_node :accept_cheque, "acceptCheque", :default_value => "false"
    text_node :custom_field_1, "customField1", :default_value => ""
    text_node :custom_field_2, "customField2", :default_value => ""
    text_node :twitter_id, "twitterID", :default_value => ""
    text_node :skype_id, "skypeID", :default_value => ""    
  end
end