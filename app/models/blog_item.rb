class BlogItem < EntryItem

  def source_model
    if url.include?('gov.uk')
      GovernmentSource
    elsif url.include?('parliament.uk')
      ParliamentSource
    else
      BlogSource
    end
  end

end
