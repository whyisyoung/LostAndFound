require "spec_helper"

describe "Category pages" do
  subject { page }

  describe "show lost_items categorized by category_id" do
    let(:user)   { FactoryGirl.create(:user) }

    # to specify category_id equals 3, we should create 3 categories first.
    let!(:category) { FactoryGirl.create(:category, name: 'electronics') }
    let!(:category2) { FactoryGirl.create(:category, name: 'cards') }
    let!(:category3) { FactoryGirl.create(:category, name: 'belongings') }

    # we have specify the same detail in factories.rb, so we have to modify it.
    let!(:item1) { FactoryGirl.create(:lost_item, user: user, category_id: 1, detail: "Hello") }
    let!(:item2) { FactoryGirl.create(:lost_item, user: user, category_id: 1, detail: "World")  }
    let!(:item3) { FactoryGirl.create(:lost_item, user: user, category_id: 3, detail: "No")  }
    before do
      visit category_path(1)
    end

    it { should have_title('electronics') }
    it { should have_content(item1.detail) }
    it { should have_content(item2.detail) }
    it { should_not have_content(item3.detail) }

    it { should have_link(item1.detail,
                href: user_lost_item_path(user, item1)) }
    it { should have_link(item2.detail,
                href: user_lost_item_path(user, item2)) }


  end
end