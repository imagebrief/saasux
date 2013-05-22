module SaasuX
  class ContactResponse
    include XML::Mapping
    
    object_node :errors, "errors", :class => Errors, :default_value => nil
    object_node :contact, "contact", :class => Contact, :default_value => nil
  end
end