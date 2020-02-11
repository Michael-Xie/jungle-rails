require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be created with password and password_confirmation fields" do
    user = User.new({ password: "test", password_confirmation: "test" })
    expect(user).to be_valid

  end
  it "should not be created with non-matching password" do
    user = User.new({ password: "test", password_confirmation: "wrong" })
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")

  end

  it "should have unique emails in database" do
    user1 = User.new({email: "test@test.com", password: "test", password_confirmation: "test"})
    user1.save()
    user2 = User.new({email: "test@test.com", password: "hi", password_confirmation: "hi"})
    # user2.save()
    expect(user2).to_not be_valid
    expect(user2.errors.full_messages).to include("Email has already been taken")
  end

  it "should have a password with at least 6 characters" do
    # user = User.new(first_name:"first", last_name:"last", password_digest:"sixsix", email:"test@test.com")
    # expect(@user.password_digest.length()).to be >= 6
  end
end
