module SaasuX
  class UpdateContact
    include XML::Mapping
    object_node :contact, "contact", :class => Contact
  end
end