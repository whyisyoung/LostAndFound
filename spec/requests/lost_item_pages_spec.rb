require "spec_helper"

describe "LostItem pages nested with User" do
	subject { page }

	describe "when create new lost_item" do
		let(:user) { FactoryGirl.create(:user) }
		let(:submit) { "Create new lost_item"}
		before { visit new_user_lost_item_path }

		it { should have_title('New Lost Item') }
		it { should have_content('New lost_item') }

		describe "with invalid information" do
			it "should not create a lost_item" do
				expect{ click_button submit }.not_to change(LostItem, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title('New Lost Item') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Detail",				with: "A white cup"
				fill_in "Finder",				with: "Lin"
				fill_in "Phone",				with: 18817551234
				fill_in "Status",				with: "unclaimed"
				fill_in "Place",				with: "Library"
				fill_in "Category",			with: 5
			end

			it "should create a lost_item" do
				expect{ click_button submit }.to change(LostItem, :count).by(1)
			end

			describe "after saving the lost_item" do
				before { click_button submit }

				it { should have_selector( 'div.alert.alert-success') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		let(:lost_item) { FactoryGirl.create(:lost_item, user: user) }
		before { visit edit_user_lost_item_path(user, lost_item) }

		describe "page" do
			it { should have_title("Edit lost_item") }
			it { should have_content("Editing lost_item") }
		end

		describe "with invalid changes" do

			context "with invalid phone" do
				before { fill_in "Phone", with: 12345 }

				it { should have_content('error')}
			end

			context "with invalid category" do
				before { fill_in "Category", with: 10 }

				it { should have_content('error') }
			end
		end

		describe "with valid changes" do
			let(:new_place) { "4# building" }
			let(:new_status) { "claimed" }
			before do
				fill_in "Place", 		with: new_place
				fill_in "Status", 	with: new_status
			end

			it { should have_selector('div.alert.alert-success') }
			specify { expect(lost_item.reload.place).to eq new_place }
			specify { expect(lost_item.reload.status).to eq new_status }
		end
	end
end