class Snake
  MAX_X = 57
  MAX_Y = 42

  def initialize(size, foods)
    @segments = [{x: 28, y: 21}]
    size.times { grow() }
    @cube = Gosu::Image.new('media/green_cube.png')
    @direction = 'right'
    @foods = foods
  end

  def move
    case @direction
    when 'up' then @segments.unshift({x: @segments.first[:x] , y: (@segments.first[:y] - 1) })
    when 'down' then @segments.unshift({x: @segments.first[:x] , y: (@segments.first[:y] + 1) })
    when 'left' then @segments.unshift({x: @segments.first[:x] - 1 , y: @segments.first[:y] })
    when 'right' then @segments.unshift({x: @segments.first[:x] + 1 , y: @segments.first[:y] })
    end
    @segments.pop

    @foods.each do |food|
      if @segments.first[:x] == food.x && @segments.first[:y] == food.y
        food.eat!
        3.times { grow() }
      end
    end

  end

  def draw
    @segments.each do |segment|
      @cube.draw(segment[:x] * 11 + 1, segment[:y] * 11 + 1, 0)
    end

    @foods.each {|food| food.draw}
  end

  def dead?
    return true if @segments.first[:x] < 0 || @segments.first[:x] > MAX_X || @segments.first[:y] < 0 || @segments.first[:y] > MAX_Y

    @segments.each_with_index do |segment, index|
      next if index.zero?
      head = @segments.first
      return true if head[:x] == segment[:x] && head[:y] == segment[:y]
    end

    false
  end

  def change_direction(new_direction)
    @direction = new_direction
  end

  private

  def grow
    @segments << @segments.last.dup
  end

end