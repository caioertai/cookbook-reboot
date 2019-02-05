class Recipe
  attr_reader :name, :description, :prep_time

  def initialize(attributes)
    @name        = attributes[:name]
    @description = attributes[:description]
    @prep_time   = attributes[:prep_time]
    @done        = attributes[:done] == 'true'
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def to_a
    [name, description, prep_time, done?]
  end

  def self.attributes
    ['name', 'description', 'prep_time', 'done']
  end
end
