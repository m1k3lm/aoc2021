DELIMITERS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
  }
OPENING_DELIMITERS = DELIMITERS.keys
CLOSING_DELIMITERS = DELIMITERS.values

class Puzzle

    def initialize(filename)
        @lines = File.open(filename, "r").readlines.map { |line| line.chomp }
    end

    def readline(string)
        stack  = []
        string.each_char do |ch|
            if OPENING_DELIMITERS.include?(ch)
            stack << ch
            elsif CLOSING_DELIMITERS.include?(ch)
            ch == DELIMITERS[stack.last] ? stack.pop : (return @scores[ch])
            end
        end
        return 0
    end

    def completeline(string)
        stack  = []
        string.each_char do |ch|
            if OPENING_DELIMITERS.include?(ch)
            stack << ch
            elsif CLOSING_DELIMITERS.include?(ch)
            ch == DELIMITERS[stack.last] ? stack.pop : (return @scores[ch])
            end
        end
        ret = ''
        while !stack.empty?
            ret += DELIMITERS[stack.pop]
        end
        return ret
    end

    def solve_part1
        sum = 0
        @scores = {
            ")" => 3,
            "]" => 57,
            "}" => 1197,
            ">" => 25137
        }
        @lines.each { |line| sum +=readline(line) }
        return sum
    end

    def solve_part2
        @scores = {
            ")" => 1,
            "]" => 2,
            "}" => 3,
            ">" => 4
        }
        incomplete_lines = @lines.select { |line| readline(line)==0 }
        points = incomplete_lines.map{ |line| completeline(line).chars.reduce(0) { |sum, ch| 5*sum + @scores[ch] } }.sort
        puts points
        return points[((points.length-1)/2) ]

    end
end