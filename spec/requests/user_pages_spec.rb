require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  describe "register page" do
  	before { visit register_path }

  	it { should have_content( 'Register' ) }
  	it { should have_title( full_title('Register') ) }
  end

  describe "register" do
  	before { visit register_path }
  	let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
  	end
  end

  describe "profile page" do
  	let( :user ) { FactoryGirl.create( :user ) }
  	before { visit user_path( user ) }

  	it { should have_content( user.name ) }
  	it { should have_title( user.name ) }
  end
end
