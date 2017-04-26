require "test_helper"
class JekyllMultiPaginateTest < Test::Unit::TestCase
  def test_version
  	assert_equal "0.1.1", Jekyll::Multi::Paginate::VERSION 
  end
end