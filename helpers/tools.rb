module ToolsHelper

  # return array of hashes
  def extract_radusers(klass)
    klass = klass.all
    klass = klass.map { |user| user.to_hash }
  end

  def build_filters(klass, params)
    if params['filter']
      # convert filters hash into array of symbols
      filters = params['filter'].map &:to_sym
      # shift first value into select & append the rest
      klass = klass.select(filters.shift)
      klass = filters.map { |f| klass = klass.select_append(f) }.last unless filters.empty?
    end
    return klass
  end

  def build_conditions(klass, params)
    # remove filterd fields and create conditions map. Return last value
    conditions = params
    conditions.delete "filter"
    unless conditions.empty?
      klass = conditions.map { |k,v| klass = klass.where(k.to_sym => v)}.last
    end
    return klass
  end

  def ensure_payload(&block)
    payload = request.body.read
    unless payload.empty?
      parsed_payload = JSON.parse(payload)
      
      block.call(parsed_payload)
    else
      status 400
      body json({ message: "No payload was passed, no data was written" })
    end
  end
end