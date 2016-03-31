require 'minitest/autorun'
require_relative '../contact'

class TestContact < Minitest::Test

  def setup
    @contact = Contact.create('Foo', 'Bar', 'foo@bar.com', 'some note')
  end

  def teardown
    Contact.delete_all
  end

  def test_all
    assert_equal [@contact], Contact.all
  end

  def test_find
    assert_equal @contact, Contact.find(@contact.id)
  end

  def test_find_by
    assert_equal [@contact], Contact.find_by('first_name', 'Foo')
  end

  def test_delete_all
    Contact.delete_all
    assert_equal 0, Contact.all.size
  end

  def test_full_name
    assert_equal 'Foo Bar', @contact.full_name
  end

  def test_update
    @contact.update('note', 'some other note')
    assert_equal 'some other note', @contact.note
  end

  def test_delete
    @contact.delete
    assert [], Contact.all
  end

end
