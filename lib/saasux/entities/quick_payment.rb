module SaasuX
  class QuickPayment
    include XML::Mapping

    text_node :date_paid, "datePaid", :default_value => ""
    text_node :date_cleared, "dateCleared", :default_value => ""

    text_node :banked_to_account_uid, "bankedToAccountUid", :default_value => ""

    text_node :amount, "amount", :default_value => ""

    text_node :reference, "reference", :default_value => ""
    text_node :summary, "summary", :default_value => ""
  end
end
