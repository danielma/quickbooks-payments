class Hash
  def symbolize_keys
    inject({}) { |memo, (k,v)| memo[k.to_sym] = v; memo }
  end
end
