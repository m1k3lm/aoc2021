class Puzzle
    @commands
    def initialize(filename)
        @commands = File.open(filename, "r").readlines.map { |line| line.chomp }
    end

    def drive
        @commands.each do |command|
            c = command.split(' ')
            case c[0]
            when 'forward'
                @h_pos += c[1].to_i
            when 'up'
                @depth -= c[1].to_i
            else
                @depth += c[1].to_i
            end
        end
    end

    def drive_aiming
        aim = 0
        @commands.each do |command|
            c = command.split(' ')
            case c[0]
            when 'forward'
                @h_pos += c[1].to_i
                @depth += aim*c[1].to_i
            when 'up'
                aim -= c[1].to_i
            else
                aim += c[1].to_i
            end
        end
    end

    def solve_part1
        @h_pos = @depth = 0
        drive
        return @h_pos * @depth
    end

    def solve_part2
        @h_pos = @depth = 0
        drive_aiming
        return @h_pos * @depth
    end
end