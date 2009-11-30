class NewsSource < EntrySource

  before_validation_on_create :default_approved_to_true

end
