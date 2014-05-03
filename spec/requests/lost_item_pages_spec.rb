require "spec_helper"

describe "LostItem pages nested with User" do
  subject { page }

  describe "when create new lost_item" do
    let(:user) { FactoryGirl.create(:user) }
    let(:submit) { 'Create Lost item'}
    let!(:category) { FactoryGirl.create(:category) }
    before do
      log_in user
      visit new_user_lost_item_path(user)
    end

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
        fill_in 'Lost time',  with: DateTime.now
        fill_in 'Detail',     with: 'A white cup'
        fill_in 'Finder',     with: 'Lin'
        fill_in 'Phone',      with: 18817551234
        select 'unclaimed',   from: 'Status'
        fill_in 'Place',      with: 'Library'
        select 'electronics', from: 'Category'
      end

      it "should create a lost_item" do
        expect{ click_button submit }.to change(LostItem, :count).by(1)
      end

      describe "after saving the lost_item" do
        before { click_button submit }

        it { should have_selector('div.alert.alert-success') }
      end
    end
  end


  describe "edit" do
    # Use let! method, force to create variables instantly.
    let!(:user) { FactoryGirl.create(:user) }
    let!(:lost_item) { FactoryGirl.create(:lost_item, user: user) }
    let!(:category) { FactoryGirl.create(:category) }
    let(:update) { 'Update Lost item' }

    before do
      log_in user
      visit edit_user_lost_item_path(user, lost_item)
    end

    describe "page" do
      it { should have_title('Edit Lost Item') }
      it { should have_content('Editing lost_item') }
    end

    describe "with invalid changes" do

      context "with invalid phone" do
        before do
          fill_in 'Phone', with: 12345
          click_button update
        end

        it { should have_content('error')}
      end

    end

    describe "with valid changes" do
      let(:new_place) { '4# building' }
      let(:new_status) { 'claimed' }
      before do
        fill_in 'Place',  with: new_place
        select new_status,  from: 'Status'
        click_button update
      end

      it { should have_selector('div.alert.alert-success') }
      specify { expect(lost_item.reload.place).to eq new_place }
      specify { expect(lost_item.reload.status).to eq new_status }
    end
  end
end