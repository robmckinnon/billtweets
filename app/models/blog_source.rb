class BlogSource < EntrySource

  before_validation_on_create :default_approved_to_false

end
