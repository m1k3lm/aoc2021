require 'set'

class Puzzle
    attr_reader :numbers, :boards

    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }
        @numbers = inputs.shift.split(",").map(&:to_i)
        @boards = []
        (0..inputs.length - 1).step(6).each do |index|
            board = []
            inputs.slice(index+1, 5).each { |line| 
                board_line = line.split(" ").map(&:to_i)
                board << board_line
            }
            @boards.push Board.new board, "B#{@boards.length}"
        end
    end
    
    def solve_part1
        @numbers.each do |number|
            @boards.each do |board|
                board.mark_element(number)
                return board.get_score*number if board.bingo?
            end
        end
    end

    def solve_part2
        value = 0
        @numbers.each do |number|
            @boards.each do |board|
                board.mark_element(number)
                value = board.get_score*number if board.bingo?
            end
            @boards.delete_if { |board| board.bingo? }
        end
        return value
    end
end

class RowColumn
    def initialize(elements,id)
        @id = id
        @elements = Set.new elements
        @marked_value = 0
    end
    def mark_element(element)
        if @elements.include? element
            @elements.delete element
        end
        @elements.empty?
    end
    def sum
        @elements.sum
    end
    def to_a
        @elements.to_a
    end
end

class Board
    def initialize(board_elements,id)
        @id = id
        @row_columns = []
        board_elements.each_with_index do |element,index|
            @row_columns << RowColumn.new(element,"R#{index}-#{id}")
        end
        board_elements.transpose.each_with_index do |element,index|
            @row_columns<< RowColumn.new(element,"C#{index}-#{id}")
        end
        @bingo = false
    end

    def mark_element(element)
        (0..4).each do |i|
            #puts "RowColumn #{r} #{@id} #{@row_columns[i].to_a.join(',')} el:#{element}"
            r = @row_columns[i].mark_element(element)
            c = @row_columns[i+5].mark_element(element)
            @bingo = true if  r || c
        end
    end

    def bingo?
        @bingo
    end

    def get_score
        return self.to_a.flatten.sum
    end

    def to_a
        @row_columns.slice(0,5).map(&:to_a)
    end
end
