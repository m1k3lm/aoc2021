$LOAD_PATH << '.'
require 'test/unit'
require 'main'
class TestDay6 < Test::Unit::TestCase
    def test_cantor_number
        puts cantor_number_good(1, 18)
        puts cantor_number_good(2, 18)
        puts cantor_number_good(3, 18)
        puts cantor_number_good(4, 18)
        puts cantor_number_good(5, 18)
        puts cantor_number_good(6, 18)
        puts cantor_number_good(0, 18)


        expected = 1
        assert_equal expected, cantor_number(1, 0)
        assert_equal expected, cantor_number(0, 0)
        assert_equal expected, cantor_number(1, 1)
        assert_equal expected, cantor_number(6, 6)
        assert_equal expected, cantor_number(7, 7)
        assert_equal expected, cantor_number(8, 8)
        assert_equal expected, cantor_number(8, 8)
        assert_equal expected, cantor_number(6, 1)
        expected = 2
        assert_equal expected, cantor_number(0, 1)
        assert_equal expected, cantor_number(1, 2)
        assert_equal expected, cantor_number(2, 3)
        assert_equal expected, cantor_number(3, 4)
        assert_equal expected, cantor_number(4, 5)
        assert_equal expected, cantor_number(5, 6)
        assert_equal expected, cantor_number(6, 7)
        assert_equal expected, cantor_number(7, 8)
        assert_equal expected, cantor_number(8, 9)
        assert_equal expected, cantor_number_good(0, 6)
        assert_equal expected, cantor_number(0, 6)
        assert_equal expected, cantor_number_good(0, 7)
        assert_equal expected, cantor_number(0, 7)


        expected = 3
        assert_equal expected, cantor_number_good(0, 8)
        assert_equal expected, cantor_number(0, 8)
        assert_equal cantor_number_good(1, 18), cantor_number(1, 18)
        assert_equal cantor_number_good(2, 18), cantor_number(2, 18)
        assert_equal cantor_number_good(3, 18), cantor_number(3, 18)
        assert_equal cantor_number_good(4, 18), cantor_number(4, 18)
        assert_equal cantor_number_good(0, 2), cantor_number(0, 2)
        assert_equal cantor_number_good(0, 6), cantor_number(0, 6)
        assert_equal cantor_number_good(6, 6), cantor_number(6, 6)
        assert_equal cantor_number_good(8, 6), cantor_number(8, 6)
        assert_equal cantor_number_good(0, 7), cantor_number(0, 7)
        assert_equal cantor_number_good(0, 8), cantor_number(0, 8)
        assert_equal cantor_number_good(0, 12), cantor_number(0, 12)
        assert_equal cantor_number_good(0, 14), cantor_number(0, 14)

        assert_equal cantor_number_good(0, 18), cantor_number(0, 18)
        assert_equal cantor_number_good(1, 18), cantor_number(1, 18)
        assert_equal cantor_number_good(2, 18), cantor_number(2, 18)
        assert_equal cantor_number_good(3, 18), cantor_number(3, 18)
        assert_equal cantor_number_good(4, 18), cantor_number(4, 18)
        assert_equal cantor_number_good(5, 18), cantor_number(5, 18)
        assert_equal cantor_number_good(6, 18), cantor_number(6, 18)
    


    end
end