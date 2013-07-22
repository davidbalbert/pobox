require 'test_helper'

class FormTest < ActiveSupport::TestCase
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

  def setup
    @form = PersonForm.new
  end

  test "delegates attributes to wrapped objects" do
    @form.name = "David"
    assert_equal "David", @form.person.name

    @form.person.name = "Nicholas"
    assert_equal "Nicholas", @form.name
  end

  test "should be valid if its wrapped objects are valid" do
    assert !@form.person.valid? && !@form.valid?

    @form.person.name = "David"

    assert @form.person.valid? && @form.valid?
  end

  test "should copy errors over from wrapped objects" do
    @form.valid?

    assert_equal @form.person.errors.size, @form.errors.size
    assert_equal @form.person.errors.first, @form.errors.first
  end

  test "should only copy errors over for wrapped fields" do
    @form.person.valid?
    @form.person.errors.add(:fake_field, 'has an error')

    @form.send(:populate_errors)
    assert !@form.errors.has_key?(:fake_field), "Error for :fake_field coppied over even though PersonForm doesn't wrap :fake_field."
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
