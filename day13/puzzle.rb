class Puzzle
    attr_accessor :points, :folds
    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @points = []
        @folds = []
        inputs.each do |input|
            break if input.empty?
            @points << input.split(',').map(&:to_i)
        end
        inputs.select { |line| line.chars.include?("=") }.each do |line|
            @folds << line.split('=')
        end
    end

    def plot
        xmax = @points.map{|p| p[0]}.max
        ymax = @points.map{|p| p[1]}.max
        map = Array.new(xmax+1) { Array.new(ymax+1) { ' ' } }
        @points.each do |point|
            map[point[0]][point[1]] = '#'
        end
        map.transpose.each do |line|
            puts line.join
        end
    end

    def apply_folds(n=nil)   
        @folds.each do |fold|
            case fold[0]
            when "fold along x"
                @points.select{|p| p[0]>fold[1].to_i}.each do |point|
                    point[0] = 2 * fold[1].to_i - point[0]
                end
            when "fold along y"
                @points.select{|p| p[1]>fold[1].to_i}.each do |point|
                    point[1] = 2 * fold[1].to_i - point[1]
                end
            end
            if !n.nil?
                break if n == 0
                n -= 1
            end
        end
    end

    def solve_part1
        apply_folds(1)
        @points.uniq.length
    end

    def solve_part2
        apply_folds
        plot
    end
end