require 'test_helper'

class Person
  include ActiveModel::Model

  attr_accessor :name

  validates :name, presence: true
end

class PersonForm < Form
  wraps person: [:name]

  def person
    @person ||= Person.new
  end
end

class FormTest < ActiveSupport::TestCase
  def setup
    @form = PersonForm.new
  end

  test "delegates attributes to wrapped objects" do
    @form.name = "David"
    assert_equal @form.person.name, "David"

    @form.person.name = "Nicholas"
    assert_equal @form.name, "Nicholas"
  end

  test "should be valid if its wrapped objects are valid" do
    assert !@form.valid?

    @form.person.name = "David"

    assert @form.valid?
  end

  test "should copy errors over from wrapped objects" do
    @form.valid?

    assert_equal @form.errors.size, @form.person.errors.size
    assert_equal @form.errors.first, @form.person.errors.first
  end

  test "should save wrapped objects on submit" do
    @form.name = "David"
    @form.person.expects(:save)
    assert @form.submit
  end

  test "shouldn't save wrapped objects if it is invalid" do
    @form.person.expects(:save).never
    assert !@form.submit
  end
end
