# frozen_string_literal: true

class WrongUserKindError < StandardError
  ERROR_MESSAGE = 'Wrong user kind.'

  def initialize
    super(ERROR_MESSAGE)
  end
end
