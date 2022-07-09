# frozen_string_literal: true

json.objectives do
  json.array! objectives do |objective|
    json.partial! 'objectives/objective', objective:
  end
end
