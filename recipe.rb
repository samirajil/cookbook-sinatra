class Recipe
  attr_accessor :name, :description, :time_to_cook, :done, :difficulty

  def initialize(name, description, time_to_cook = "n/a", done = "false", difficulty = "n/a")
    @name = name
    @description = description
    @time_to_cook = time_to_cook
    @done = done
    @difficulty = difficulty
  end

  def mark_as_done
    @done = "true"
  end
end
