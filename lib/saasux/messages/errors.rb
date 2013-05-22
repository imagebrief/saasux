module SaasuX
  class Errors
    include XML::Mapping
    object_node :error, "error", :class => Error, :default_value => nil
  end
end