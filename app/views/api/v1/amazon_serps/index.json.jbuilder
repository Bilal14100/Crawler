json.amazon_serps do
  json.array! @amazon_serps do |amazon_serp|
    json.partial! "amazon_serp", amazon_serp: amazon_serp
  end
end