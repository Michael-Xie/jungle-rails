require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be created with password and password_confirmation fields" do
    user = User.new({ password: "testing", password_confirmation: "testing" , first_name: "first", last_name: "last", email: "test@test.com"})
    expect(user).to be_valid

  end
  it "should not be created with non-matching password" do
    user = User.new({ password: "testing", password_confirmation: "wrongpwd", first_name: "first", last_name: "last", email: "test@test.com"})
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")

  end

  it "should have unique emails in database (case insensitive)" do
    user1 = User.new({email: "test@test.com", password: "testing", password_confirmation: "testing", first_name: "first", last_name: "last"})
    user1.save()
    user2 = User.new({email: "TEST@test.com", password: "helloworld", password_confirmation: "helloworld", first_name: "first", last_name: "last"})
    # user2.save()
    expect(user2).to_not be_valid
    expect(user2.errors.full_messages).to include("Email has already been taken")
  end

  it "should have a password with at least 6 characters" do
    user = User.new(first_name:"first", last_name:"last", password:"fiver", password_confirmation:"fiver", email:"test@test.com")
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end
end
