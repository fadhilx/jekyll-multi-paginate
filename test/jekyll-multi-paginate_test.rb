require "test_helper"
class JekyllMultiPaginateTest < Test::Unit::TestCase
  def test_version
  	assert_equal "0.1.0", Jekyll::Multi::Paginate::VERSION 
  end
end