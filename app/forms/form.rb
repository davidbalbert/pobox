class Form
  include ActiveModel::Model

  class << self
    def wraps(models)
      models.each do |name, attributes|
        model_names << name

        delegate *attributes.map { |attr| [attr, :"#{attr}="] }.flatten, to: name
      end
    end

    def model_names
      @model_names ||= []
    end
  end

  def submit
    if valid?
      ActiveRecord::Base.transaction do
        models.each { |m| m.save }
      end
      true
    else
      false
    end
  end

  def valid?(context = nil)
    valid = models.all? { |m| m.valid?(context) }
    populate_errors

    valid
  end

  private
  def populate_errors
    models.each do |model|
      model.errors.each do |attribute, error|
        errors.add(attribute, error)
      end
    end
  end

  def models
    self.class.model_names.map { |name| send(name) }
  end
end
