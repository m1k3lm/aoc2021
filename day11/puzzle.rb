class Puzzle

    def octopuses
        @octopuses.map { |row| row.join }
    end

    def flashes
        @flashes
    end

    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @octopuses = []
        @flashes = 0
        @steps = 0
        inputs.each_with_index do |line,y|
            @octopuses[y] = []
            line.chars.map(&:to_i).each_with_index do |ch,x|
                @octopuses[y][x] = ch
            end
        end
    end

    def stepforward
        self.increment_all_in_one_and_flash_if_needed
        self.set_to_0_all_over_9
        @steps += 1
        return @steps
    end

    def increment_all_in_one_and_flash_if_needed
        @octopuses.each_with_index do |row,y|
            row.each_with_index do |ch,x|
                @octopuses[y][x] += 1
                self.flash(y,x) if @octopuses[y][x] == 10
            end
        end
    end

    def set_to_0_all_over_9
        @octopuses.each_with_index do |row,y|
            row.each_with_index do |ch,x|
                if @octopuses[y][x] > 9
                    @octopuses[y][x] = 0
                end
            end
        end
    end

    def flash(y,x)
        @flashes += 1
        (y-1).upto(y+1) do |ny|
            (x-1).upto(x+1) do |nx|
                if should_eval_flash? y,x,ny,nx
                    @octopuses[ny][nx] +=1 
                    self.flash(ny,nx) if @octopuses[ny][nx] == 10
                end
            end
        end
    end

    def should_eval_flash?(y,x,ny,nx)
        return ny >= 0 && ny < @octopuses.length &&
            nx >= 0 && nx < @octopuses[ny].length &&
            (ny!=y || nx!=x)
    end

    def solve_part1
        @flashes = 0
        100.times do stepforward end
        return @flashes
    end

    def solve_part2
        until @octopuses.flatten.sum == 0 
            stepforward
        end
        return @steps
    end
end