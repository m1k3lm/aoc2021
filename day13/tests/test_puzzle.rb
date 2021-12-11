$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_input
        d = Puzzle.new("input_test.txt")
        assert_equal 18, d.points.length
        assert_equal [6,10], d.points[0]
        assert_equal 2, d.commands.length
        assert_equal 7, d.commands[0][1].to_i
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 17, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal nil, d.solve_part2
    end
end