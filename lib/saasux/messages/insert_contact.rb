module SaasuX
  class InsertContact
    include XML::Mapping        
    object_node :contact, "contact", :class => Contact
  end
end