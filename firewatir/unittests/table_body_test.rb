# feature tests for Tables
# revision: $Revision: 1.0 $

require 'test/unit'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TableBodyTest < Test::Unit::TestCase
  def setup
    goto_page("table_bodies.html")
  end

  def test_finds_rows_in_single_body
    table_with_one_body = browser.table(:id, "table_with_one_body")    
    body = table_with_one_body.bodies[0]

    assert_equal 2, body.rows.length
  end

  def test_does_not_mix_rows_between_many_bodies
    table_with_two_bodies = browser.table(:id, "table_with_two_bodies")
    
    first_body = table_with_two_bodies.bodies[0]
    second_body = table_with_two_bodies.bodies[1]
    
    assert_equal 2, first_body.rows.length
    assert_equal 1, second_body.rows.length
  end

  def test_returns_empty_array_if_no_rows
    table_with_empty_body = browser.table(:id, "table_with_empty_body")
    body = table_with_empty_body.bodies[0]
    rows = body.rows
    
    assert_instance_of Array, rows
    assert_equal 0, rows.length
  end

  def test_array_like_access_to_rows
    body = browser.table(:id, "table_with_one_body").bodies[0]
    assert_equal "Row #1", body[1][1].to_s
    assert_equal "Row #2", body[2][1].to_s
  end
end