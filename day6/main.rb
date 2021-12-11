class Day6
    @numbers
    @serie
    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @numbers = inputs.shift.split(",").map(&:to_i)
        @serie = Array.new(9) { Array.new(256) }
    end

    def cantor_number(n, iter)
        if @serie[n][iter].nil?
            ret = 0;
            if iter < 1
                return 1
            else
                if n == 0
                    ret += self.cantor_number(6, iter-1)
                    ret += self.cantor_number(8, iter-1)
                else
                    ret += self.cantor_number(n-1, iter-1)
                end
            end
            @serie[n][iter] = ret
        end
        return @serie[n][iter]
    end

    def solve_part1 (iter)
        solution = 0
        @numbers.each do |n|
            #puts "n #{n} cn #{cn[n]} cnn#{cantor_number_good(n, iter)}"
            solution += self.cantor_number(n, iter)
        end
        puts "Part 1: #{solution}"
    end
end

#d = (Day6.new ('input_test.txt'))
d = (Day6.new ('input.txt'))
d.solve_part1(18)
d.solve_part1(80)
d.solve_part1(256)