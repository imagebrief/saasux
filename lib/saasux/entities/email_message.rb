module SaasuX
  class EmailMessage
    include XML::Mapping
  
    text_node :from, "from", :default_value => ""
    text_node :to, "to", :default_value => ""
    text_node :cc, "cc", :default_value => ""
    text_node :bcc, "bcc", :default_value => ""
    text_node :subject, "subject", :default_value => ""
    text_node :body, "body", :default_value => ""
  end
    
end