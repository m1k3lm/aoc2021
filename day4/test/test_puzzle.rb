$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_input_reading
        day4 = Puzzle.new ('input_test.txt')
    	expected = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
    	assert_equal expected, day4.numbers
        boards = day4.boards
        expected = [
            [3,15,0,2,22],
            [9,18,13,17,5],
            [19,8,7,25,23],
            [20,11,10,24,4],
            [14,21,16,12, 6]
        ]
    	assert_equal expected, boards[1].to_a
    end

    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 4512, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 1924, d.solve_part2
    end
end