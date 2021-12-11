$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_input
        d = Puzzle.new("input_test.txt")
        assert_equal 6, d.nodes.length
        assert_equal 2, d.nodes['start'].nodes.length
        assert_equal 4, d.nodes['A'].nodes.length
        assert_equal 4, d.nodes['b'].nodes.length
        assert_equal 2, d.nodes['end'].nodes.length
        assert_equal 1, d.nodes['c'].nodes.length
        assert_equal 1, d.nodes['d'].nodes.length
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 10, d.solve_part1
        d = Puzzle.new("input_test_1.txt")
        assert_equal 19, d.solve_part1
        d = Puzzle.new("input_test_2.txt")
        assert_equal 226, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 36, d.solve_part2
        d = Puzzle.new("input_test_1.txt")
        assert_equal 103, d.solve_part2
        d = Puzzle.new("input_test_2.txt")
        assert_equal 3509, d.solve_part2
    end
end