require File.expand_path(File.dirname(__FILE__) + '/../lib/rank')
require 'test/unit'

class RankTest < Test::Unit::TestCase
  def test_compare
    first = {:id => 10}
    second = {:id => 20}
    assert_equal -1, Rank.compare(first, second, :id)
    assert_equal  0, Rank.compare(first, first, :id)
    assert_equal  1, Rank.compare(second, first, :id)
  end
  
  def test_compare_with_multiple_attributes
    first = {:one => 1, :two => 'b'}
    second = {:one => 2, :two => 'a'}
    assert_equal  1, Rank.compare(first, second, :two, :one)
    assert_equal -1, Rank.compare(first, second, :one, :two)
    assert_equal  0, Rank.compare(first, first, :one, :two)
    assert_equal  0, Rank.compare(first, first, :two, :one)
  end

  def test_setting_rank_without_ties
    first = {:id => 1}
    second = {:id => 2}
    Rank.add_rank [first, second], :attributes => :id, :ties => false
    assert_equal 1, first[:rank]
    assert_equal 2, second[:rank]
  end
  
  def test_setting_rank_with_ties
    first = {:one => 1}
    second = {:one => 1}
    third = {:one => 2}
    Rank.add_rank [first, second, third], :attributes => :one, :ties => true
    assert_equal 1, first[:rank]
    assert_equal 1, second[:rank]
    assert_equal 3, third[:rank]
  end

  def test_always_ranking_nil_values_last
    first = {:one => 1}
    second = {:one => nil}
    third = {:one => 2}
    
    Rank.add_rank [first, second, third], :attributes => [[:one, :asc]], :ties => true, :sort => true
    assert_equal 1, first[:rank]
    assert_equal 2, third[:rank]
    assert_equal 3, second[:rank]
    
    Rank.add_rank [first, second, third], :attributes => [[:one, :desc]], :ties => true, :sort => true
    assert_equal 1, third[:rank]
    assert_equal 2, first[:rank]
    assert_equal 3, second[:rank]
  end
end