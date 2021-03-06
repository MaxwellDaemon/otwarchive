class TagQuery < Query

  def klass
    'Tag'
  end

  def index_name
    TagIndexer.index_name
  end

  def document_type
    TagIndexer.document_type
  end

  def filters
    [type_filter, canonical_filter].compact
  end

  def queries
    [name_query].compact
  end

  ################
  # FILTERS
  ################

  def type_filter
    { term: { tag_type: options[:type] } } if options[:type]
  end

  def canonical_filter
    { term: { canonical: 'true' } } if options[:canonical]
  end

  ################
  # QUERIES
  ################

  def name_query
    return unless options[:name]

    name = escape_reserved_characters(options[:name])
    { match_phrase: { name: name } } if options[:name]
  end

end
