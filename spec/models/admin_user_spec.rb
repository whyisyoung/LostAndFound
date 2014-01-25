require 'spec_helper'

describe AdminUser do
  before do
    @admin = AdminUser.new(email: 'test@example.com',
                           password: 'password',
                           password_confirmation: 'password')
  end

  subject { @admin }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when email is not present" do
    before { @admin.email = '' }
    it { should_not be_valid }
  end

  # shared examples for User and AdminUser
  it_should_behave_like "correct user"

end
