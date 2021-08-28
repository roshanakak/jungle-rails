require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 

    it 'is valid with matching password and password_confirmation fields' do
      @user = User.new(name: "Chicken", email: "1@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(@user).to be_valid
    end

    it 'is invalid with non-matching password and password_confirmation fields' do
      @user = User.new(name: "Chicken", email: "1@1.com", password:"poulet", password_confirmation:"pollo")
      expect(@user).to_not be_valid
    end

    it 'is valid with unique, case insensitive emails' do 
      @user1 = User.new(name: "Chicken", email: "a@1.com", password:"pollo1", password_confirmation:"pollo1")
      @user2 = User.new(name: "Chicken", email: "A@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(@user1).to be_valid
      expect(@user2).to be_valid
    end

    it 'is invalid with repeated emails' do 
      @user1 = User.new(name: "Chicken", email: "1@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(@user1).to be_valid
      @user1.save!
      @user2 = User.new(name: "Chicken", email: "1@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(@user2).to_not be_valid
    end

    it 'requires emails and names' do
      @user1 = User.new(name: nil, email: "1@1.com", password:"poulet", password_confirmation:"poulet")
      expect(@user1).to_not be_valid
      @user2 = User.new(name: "Chicken", email: nil, password:"poulet", password_confirmation:"poulet")
      expect(@user2).to_not be_valid
    end

    it 'must have a minimum password length of 6 when a user account is being created' do
      @user = User.new(name: "Chicken", email: "1@1.com", password:"four", password_confirmation:"pollo")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'must login when a registered user provides the correct email and password' do
      @user = User.create(name: "Chicken", email: "testing@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(User.authenticate_with_credentials("testing@1.com", "pollo1")).to eq(@user)
    end

    it 'must not login when an incorrect email or password is provided' do
      @user = User.create(name: "Chicken", email: "testing@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(User.authenticate_with_credentials("testing@1.com", "wrongpassword")).to eq(nil)
      expect(User.authenticate_with_credentials("wrongemail@1.com", "pollo1")).to eq(nil)
    end

    it 'must login and ignore leading and trailing spaces for e-mails' do
      @user = User.create(name: "Chicken", email: "testing@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(User.authenticate_with_credentials("   testing@1.com ", "pollo1")).to eq(@user)
    end

    it 'must login and be case insensitive for e-mails' do
      @user = User.create(name: "Chicken", email: "testing@1.com", password:"pollo1", password_confirmation:"pollo1")
      expect(User.authenticate_with_credentials("TeStIng@1.cOm", "pollo1")).to eq(@user)
    end
  end
  
endrequire 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end