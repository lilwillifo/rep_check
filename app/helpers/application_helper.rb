module ApplicationHelper
  def cache_key_for(model, key_name)
    [key_name, model.count,model.maximum(:updated_at)].join('-')
  end
end
