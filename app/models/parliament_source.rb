class ParliamentSource < EntrySource

  before_validation_on_create :default_ok_to_true

end
