class BlogSource < EntrySource

  before_validation_on_create :default_approved_to_false

  def default_approved_to_false
    self.approved = false
  end
end
