require 'spec_helper'

describe "Admin Pages" do

	subject { page }

	let(:admin) { FactoryGirl.create(:admin_user) }
	before(:each) do
		log_in_admin(admin)
	end

	it { should have_link(admin.email, href: admin_admin_user_path(admin))}

	describe "Sign out" do
		it "shoud sign out a user" do
			click_link 'Logout'
			expect(page).to have_content('Login')
		end
	end

	describe "Dashboard page" do
		before(:each) do
			visit admin_dashboard_path
		end

		it { should have_content('Dashboard') }
		it { should have_content('Recent LostItems') }

		it "should show recent five lost_items" do
			LostItem.order('created_at desc').limit(5).each do |item|
				expect(page).to have_selector('td', text: item.detail)
			end
		end
	end

	describe "LostItems page" do
		let!(:item) { FactoryGirl.create(:lost_item) }
		let(:listed_attributes) { ["Id", "Lost Time", "Detail", "Finder", "Phone", "Status", "Place"] }
		let(:unlisted_attributes) { ["user_id", "category_id"] }

		before(:each) do
			visit admin_lost_items_path
		end

		it { should have_content('New Lost Item') }
		it { should have_content(item.detail) }
		it { should have_selector('li.scope.unclaimed')}

		it "should list some attributes" do
			listed_attributes.each do |attribute|
				expect(page).to have_content(attribute)
			end
		end

		it "should not list other attributes" do
			unlisted_attributes.each do |attribute|
				expect(page).not_to have_content(attribute)
			end
		end

	end

	describe "Users page" do
		let!(:user) { FactoryGirl.create(:user) }
		let(:listed_attributes) { ["Id", "Name", "Email", "Update Time"] }
		let(:unlisted_attributes) { ["password_digest", "remember_token"] }

		before(:each) do
			visit admin_users_path
		end
		it { should have_content('New User') }
		it { should have_content(user.name) }

		it "should list some attributes" do
			listed_attributes.each do |attribute|
				expect(page).to have_content(attribute)
			end
		end

		it "should not list other attributes" do
			unlisted_attributes.each do |attribute|
				expect(page).not_to have_content(attribute)
			end
		end
	end

	describe "Categories page" do
		before(:each) do
			visit admin_categories_path
		end

		it { should have_content('New Category') }
	end

	describe "Admin Users page" do
		before(:each) do
			visit admin_admin_users_path
		end

		it { should have_content('New Admin User') }
	end

	describe "Comments page" do
		before(:each) do
			visit admin_comments_path
		end

		pending
	end
end