class Puzzle

    def initialize(filename)
        inputs =  File.open(filename, "r").readlines.map { |line| line.chomp }
        @map = []
        inputs.each do |line|
            @map << line.chars
        end
    end

    def move_east
        @map.map! do |line|
            wrappedline = [line.last] + line + [line.first]
            wrappedline
                .join
                .gsub(/\>\./, ".>")
                .chars[1..-2]
        end
    end

    def move_south
        vmap = @map.transpose
        vmap.map! do |line|
            wrappedline = [line.last] + line + [line.first]
            wrappedline
                .join
                .gsub(/v\./, ".v")
                .chars[1..-2]
        end
        @map = vmap.transpose
    end

    def next_step
        move_east
        move_south
    end

    def plot 
        puts "Afer #{@steps} steps:"
        @map.each{ |l| puts l.join }
    end

    def solve_part1
        prev = []
        @steps = 0
        puts @map.inspect
        while @map!=prev
            prev = @map.dup
            puts "Steps: #{@steps}"
            next_step
            @steps +=1
        end
        @steps
    end

    def solve_part2
    end
end