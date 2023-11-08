require_relative '../test_init'
require_relative '../../lib/patterns/form_object'

RegistrationFormObject = Class.new(Patterns::FormObject) do
  attr_accessor :name, :password, :password_confirmation
  validates :name, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end

test 'includes ActiveModel::Model' do
  assert(RegistrationFormObject < ActiveModel::Model)
end

context ".new" do
  context "returns form instance" do
    CustomForm = Class.new(Patterns::FormObject)

    form = CustomForm.new()

    test do
      assert(form.is_a?(CustomForm))
    end
  end

  context "assigns form attributes" do
    CustomForm = Class.new(Patterns::FormObject) do
      attr_accessor :first_name, :last_name
    end

    form = CustomForm.new({ first_name: "Tony", last_name: "Soprano" })

    test do
      assert(form.first_name == "Tony")
      assert(form.last_name ==  "Soprano")
    end
  end

  context "handles both symbols and strings as attribute keys" do
    CustomForm = Class.new(Patterns::FormObject) do
      attr_accessor :first_name, :last_name, :age
    end

    form = CustomForm.new({ first_name: "Christoff", "last_name" => "Pjatrowski", "age" => 400 })

    test do
      assert(form.first_name ==  "Christoff")
      assert(form.last_name == "Pjatrowski")
      assert(form.age == 400)
    end
  end
end

context "When form object is valid" do
  subject = RegistrationFormObject.new(
    name: 'some name',
    password: 'some password',
    password_confirmation: 'some password'
  )
  test do
    assert(subject.valid?)
  end
end

context "when form has errors" do
  subject = RegistrationFormObject.new(
    name: 'some name',
    password: 'some password',
    password_confirmation: 'some other password'
  )

  test 'it is invalid' do
    assert(subject.invalid?)
  end

  test 'it provides errors' do
    assert(subject.errors.full_messages == ["Password confirmation doesn't match Password"])
  end
end
