require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  describe "sign out" do
    let(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in user
    end
    it "should sign out a user" do
      click_link "Sign out"
      expect(page).to have_content("Sign in")
    end
  end

  describe "register" do
  	before { visit register_path }
  	let(:submit) { "Create my account" }

    it { should have_content( 'Register' ) }
    it { should have_title( full_title('Register') ) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title( 'Register' ) }
        it { should have_content( 'error' ) }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirm password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let( :user ) { User.find_by_email( 'user@example.com' ) }

        it { should have_link('Sign out') }
        it { should have_title( user.name ) }
        it { should have_selector( 'div.alert.alert-success', text: 'Welcome' ) }
      end
  	end
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }

    let!(:item1) { FactoryGirl.create(:lost_item, user: user, detail: "Backpack")}
    let!(:item2) { FactoryGirl.create(:lost_item, user: user, detail: "Cup")}

    shared_examples_for "common user" do
      it { should have_content( user.name ) }
      it { should have_title( user.name ) }

      it { should have_content(item1.detail) }
      it { should have_content(item2.detail) }
      it { should have_content(user.lost_items.count) }
      it { should have_link(item1.detail, href: user_lost_item_path(user, item1)) }
      it { should have_link(item2.detail, href: user_lost_item_path(user, item2)) }
    end

    shared_examples_for "authenticated user" do
      it { should have_link('edit',   href: edit_user_lost_item_path(user,item1)) }
      it { should have_link('delete', href: user_lost_item_path(user, item1)) }
      it "be able to delete a lost_item" do
        expect do
          click_link( 'delete', match: :first )
        end.to change( LostItem, :count ).by(-1)
      end
    end

    describe "user visits his own profile" do
      
      before do
        sign_in user
        visit user_path(user)
      end

      it_should_behave_like "authenticated user"
    end

    describe "admin user visits the user's profile" do
      
      before do
        sign_in admin
        visit user_path(user)
      end

      it_should_behave_like "authenticated user"
    end

    describe "another user visits the user's profile" do
      
      before do
        sign_in another_user
        visit user_path(user)
      end

      it_should_behave_like "common user"
      it { should_not have_link('edit') }
      it { should_not have_link('delete') }

      describe "should not be able to visit the user's new item page" do
        before { visit new_user_lost_item_path(user) }
        it { should_not have_title('New Lost Item')}
      end

      describe "should not be able to create lost_item for the user" do
        before { post user_lost_items_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end

      describe "should not be able to edit the user's lost_items" do
        before { visit edit_user_lost_item_path(user, item1) }
        it { should_not have_title('Edit Lost Item') }
      end

      describe "should not be able to delete the user's lost_items" do
        before { delete user_lost_item_path(user, item1) }
        specify{ expect(response).to redirect_to(root_path) }
      end
    end
  end

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create( :user, name: "Bob", email: "bob@example.com" )
      FactoryGirl.create( :user, name: "Ben", email: "ben@example.com" )
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }
    end

    it "should list each user" do
      User.paginate(page: 1).each do |user|
        expect(page).to have_selector( 'li', text: user.name )
      end
    end

    describe "delele links" do
      
      it { should_not have_link('delele') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        
        before do
          click_link "Sign out"
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link( 'delete', match: :first )
          end.to change( User, :count ).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user) 
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before { put user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_content("Current Password") }
      it { should have_title("Edit user") }
      it { should have_link( 'change', href: 'http://gravatar.com/emails') }
    end

    describe "with nothing changed" do
      before { click_button "Save changes" }

      it { should_not have_content("Profile updated") }
      it { should_not have_content("Invalid current password") }
    end

    describe "with invalid current password" do
      before do 
        fill_in "New Name",             with: "New name"
        fill_in "New Email",            with: "new@example.com"
        fill_in "current_password",     with: "invalid" 
        fill_in "user_password",        with: "newpassword"
        fill_in "Confirm New Password", with: "newpassword"
        click_button "Save changes"
      end

      it { should have_content('Invalid current password') }
    end

    describe "with valid current password" do
      let( :new_name )  { "New name" }
      let( :new_email ) { "new@example.com" }
      before { fill_in "current_password",   with: "foobar" }

      context "with nothing changed" do
        before { click_button "Save changes" }

        it { should_not have_content("Profile updated") }
      end

      context "with invalid information" do
        before do
          fill_in "Name",  with: new_name
          fill_in "Email", with: new_email
        end

        describe "with new password blank and confirmation not blank" do
          before do
            fill_in "Confirm New Password", with: "newpassword"
            click_button "Save changes"
          end

          it { should have_content('error') }
        end

        describe "with short password" do
          before do
            fill_in "user_password",        with: "a"
            fill_in "Confirm New Password", with: "a"
            click_button "Save changes"
          end

          it { should have_content("error")}
        end

        describe "with password does not match confirmation" do
          before do
            fill_in "user_password",        with: "newpassword"
            fill_in "Confirm New Password", with: "invalid"
            click_button "Save changes"
          end

          it { should have_content("error")}
        end
      end


      context "with valid information" do
        before do
          fill_in "Name",  with: new_name
          fill_in "Email", with: new_email
        end

        describe "with all changed" do        
          before do
            fill_in "user_password",        with: "newpassword"
            fill_in "Confirm New Password", with: "newpassword"
            click_button "Save changes"
          end

          it { should have_title(new_name) }
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', href: signout_path) }
          specify { expect(user.reload.name).to eq new_name }
          specify { expect(user.reload.email).to eq new_email }
        end

        describe "with new password and confirmation blank" do
          before { click_button "Save changes" }

          it { should have_selector('div.alert.alert-success') }
        end
      end
    end
  end

end
