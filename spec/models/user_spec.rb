require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(first_name: "First", last_name: "Last", password: "password", email: "john@doe.com", password_confirmation: "password") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'should have matching password and password confirmation' do
      subject.password_confirmation = "notpass"
      expect(subject).to_not be_equal(subject.password_confirmation)
    end

    it 'should have a password with a minimum length of 6' do
      subject.password = "six"
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is not nil with correct authentication' do
    user = User.create({
      first_name: "First",
      last_name: "Last", password: "password",
      email: " john@doe.COM ",
      password_confirmation: "password"
    })
    expect(User.authenticate_with_credentials(user.email, user.password)).to_not be_equal(nil)
   end
  end
end
