module SaasuX
  class UpdateContactResult
    include XML::Mapping
    text_node :updated_entity_uid, "@updatedEntityUid", :default_value => ""
    text_node :last_updated_uid, "@lastUpdatedUid", :default_value => ""
    text_node :utc_last_modified, "utcLastModified", :default_value => ""

    object_node :errors, "errors", :class => Errors, :default_value => nil
  end
end