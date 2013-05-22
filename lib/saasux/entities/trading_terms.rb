module SaasuX
  class TradingTerms
    include XML::Mapping
    
    text_node :_type, "type", :default_value => "" # note ':type' is reserved and displays class name
    text_node :interval, "interval", :default_value => ""
    text_node :interval_type, "intervalType", :default_value => ""
    text_node :type_enum, "typeEnum", :default_value => ""
    text_node :interval_type_enum, "intervalTypeEnum", :default_value => ""
    
  end
end