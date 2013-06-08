module SaasuX
  class DeleteContactResult
    include XML::Mapping

    text_node :uid, "@uid", :default_value => ""
    object_node :errors, "errors", :class => Errors, :default_value => nil

  end
end