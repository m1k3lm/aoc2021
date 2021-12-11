class Puzzle
    def initialize(filename)
        @crab_positions = []
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        inputs[0].split(",").each do |input|
            @crab_positions << input.to_i
        end
    end
    def solve_part1
      fuel = []
      fuel << (@crab_positions.min..@crab_positions.max).each.map do |x|
          @crab_positions.sum { |y| (x - y).abs }
      end
      fuel.transpose.min[0]
    end
    def solve_part2
      fuel = []
      fuel << (@crab_positions.min..@crab_positions.max).each.map do |x|
          @crab_positions.sum do |y| 
            (x - y).abs.times.sum do |i| 
              i+1
            end
          end
      end
      fuel.transpose.min[0]
    end
end
