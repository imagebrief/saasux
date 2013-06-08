module SaasuX
  class ContactResponse
    include XML::Mapping
    
    choice_node :if, 'errors',          :then, (object_node :errors, "errors", :class => Errors, :default_value => nil),
                :elsif, 'contact',      :then, (object_node :contact, "contact", :class => Contact, :default_value => nil),
                :elsif, 'deleteResult', :then, (object_node :delete_result, "deleteResult", :class => DeleteContactResult, :default_value => nil)

  end
end