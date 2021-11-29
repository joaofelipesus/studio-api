# frozen_string_literal: true

json.exercises do
  json.array! exercises do |animal|
    json.animal do
      json.partial! 'exercises/animal', animal: animal
    end
  end
end
