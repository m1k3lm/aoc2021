class Puzzle
    attr_accessor :points
    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @points ||= []
        inputs.each_with_index do |input,y|
            @points[y] ||= Array.new(input.length)
            input.each_char.with_index do |char,x|
                @points[y][x] = char.to_i 
            end
        end
    end

    def low_point (y,x)
        min = true
        if y>=1 && @points[y-1][x] <= @points[y][x]
            min = false
        end

        if y<@points.length-1 && @points[y+1][x] <= @points[y][x]
            min = false
        end
        if x>= 1 && @points[y][x-1] <= @points[y][x]
            min = false
        end

        if x<@points[y].length-1 && @points[y][x+1] <= @points[y][x]
            min = false
        end
        return min
    end

    def get_lowest_points
        ret = []
        @points.each_with_index do |row,y|
            row.each_with_index do |char,x|
                if low_point(y,x)
                    ret << [y,x]
                end
            end
        end
        return ret
    end
    def print_basin (basin)
        matrix = @points.map.with_index do |row,y|
            row.map.with_index do |col, x|
                if basin.include? [y,x]
                    "*#{col}*"
                else
                    " #{col} "
                end
            end
        end
        matrix.each { |row| puts row.join }
    end

    def print_basins (basins)
        basin = []
        basins.each do
            |b| basin += b
        end
        matrix = @points.map.with_index do |row,y|
            row.map.with_index do |col, x|
                if basin.include? [y,x]
                    "*#{col}*"
                else
                    " #{col} "
                end
            end
        end
        matrix.each { |row| puts row.join,"" }
    end 

    def build_basin(point,basin = [])
        x = point[1]
        y = point[0]
        return basin if basin.include? point
        add_this = false
        puts "Start #{y},#{x}"
        if y>=1 && @points[y][x] < 9
            basin << [y,x]
            basin = build_basin([y-1,x],basin)
        end
        if y<@points.length-1 && @points[y][x] < 9
            basin << [y,x]
            basin = build_basin([y+1,x],basin)
        end
        if x>= 1 && @points[y][x] < 9
            basin << [y,x]
            basin = build_basin([y,x-1],basin)
        end
        if x<@points[y].length-1 &&  @points[y][x] < 9
            basin << [y,x]
            basin = build_basin([y,x+1],basin)
        end

        "*****BL #{basin.length} #{basin.uniq.inspect}"
        return basin.uniq
    end
    def find_basins
        basins = []
        lp = self.get_lowest_points
        puts "Lowest points: #{lp.inspect}"
        lp.each do |point|
            basin = build_basin(point)
            basins << basin
            puts "****",basin.inspect,"***"
        end
        return basins
    end

    def solve_part1
        risk = 0
        @points.each_with_index do |row,y|
            row.each_with_index do |char,x|
                puts "Eval #{y},#{x}"
                if low_point(y,x)
                    puts "Low!! #{@points[y][x]}"
                    risk += @points[y][x].to_i+1
                end
            end
        end
        return risk
    end

    def solve_part2
        result = 1;
        basins = self.find_basins
        sorted = basins.sort_by  { |x| x.length }.reverse
        list = sorted.map.with_index { |x,i| [i,x.length] }
        puts "Sorted: #{list.inspect}"
        sorted.take(3).each{ |basin| print_basin(basin) }
        sorted.take(3).reduce(1) { |res, basin| puts basin.length;basin.length * res }
    end
end
#@todo: refactor to get neighbours instead of using the 4 ifs twice.