require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here
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
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should return user information when user's credential is authenticated" do
      expected_user = User.new(first_name:"first", last_name:"last", password:"fiverfiver", password_confirmation:"fiverfiver", email:"tester@test.com")
      expected_user.save
      actual_user = expected_user.authenticate_with_credentials("tester@test.com","fiverfiver")
      expect(actual_user).to eq(expected_user)
    end

    it "should not return user information when user's credential is not authenticated" do
      expected_user = User.new(first_name:"first", last_name:"last", password:"fiverfiver", password_confirmation:"fiverfiver", email:"tester@test.com")
      expected_user.save
      actual_user = expected_user.authenticate_with_credentials("tester@test.com","fiverfiver123")
      expect(actual_user).to_not eq(expected_user)
    end

    it "should not user information when user's email has trailing spaces" do
      expected_user = User.new(first_name:"first", last_name:"last", password:"fiverfiver", password_confirmation:"fiverfiver", email:"tester@test.com")
      expected_user.save
      actual_user = expected_user.authenticate_with_credentials("  tester@test.com  ","fiverfiver")
      expect(actual_user).to eq(expected_user)
    end

    it "should not user information when user's email has different cases" do
      expected_user = User.new(first_name:"first", last_name:"last", password:"fiverfiver", password_confirmation:"fiverfiver", email:"eXample@domain.COM")
      expected_user.save
      actual_user = expected_user.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM","fiverfiver")
      expect(actual_user).to eq(expected_user)
    end

  end
end
