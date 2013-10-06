require "spec_helper"

describe LostItem do

	let(:user) { FactoryGirl.create(:user) }
	before do
		@lost_item = user.lost_items.build(lost_time: DateTime.now,
															 				 detail: 'A white cup',
															 				 place:  'The fourth teaching building',
															 				 status: 'unclaimed',
															 				 finder: 'Lin',
															 				 phone:  '18817551234',
															 				 category_id: 5)
	end

	subject { @lost_item }

	it { should respond_to(:lost_time) }
	it { should respond_to(:detail) }
	it { should respond_to(:place) }
	it { should respond_to(:status) }
	it { should respond_to(:finder) }
	it { should respond_to(:phone) }
	it { should respond_to(:category_id) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when some attributes is not present" do
		def self.it_should_require_presence_of(*attributes)
			attributes.each do |attribute|
				it { should validate_presence_of(attribute) }
			end
		end

		it_should_require_presence_of :lost_time, :detail, :finder, :place, :user_id
	end

	describe "when phone format is valid" do
		it "should be valid" do
			numbers = [13310289862, 18812345678, 14782192561, 15214167865, nil]
			numbers.each do |valid_number|
				@lost_item.phone = valid_number
				expect(@lost_item).to be_valid
			end
		end
	end

	describe "when phone format is invalid" do
		it "should be invalid" do
			numbers = [15410289862, 184123,  'a13310289764',
									14382192561, 152141647857865, 'abcde']
			numbers.each do |invalid_number|
				@lost_item.phone = invalid_number
				expect(@lost_item).not_to be_valid
			end
		end
	end

	describe "when category_id is not in right range" do
		it "should be invalid" do
			@lost_item.category_id = 10
			expect(@lost_item).not_to be_valid
		end
	end

end