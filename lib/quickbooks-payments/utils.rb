class Hash
  def symbolize_keys
    each_with_object({}) do |(k, v), memo|
      memo[k.to_sym] = v
    end
  end
end
