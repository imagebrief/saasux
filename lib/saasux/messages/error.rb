module SaasuX
  class Error
    include XML::Mapping
    text_node :type, "type", :default_value => ""
    text_node :message, "message", :default_value => ""
  end
end