class NewsSource < EntrySource

  before_validation_on_create :default_ok_to_true

end
