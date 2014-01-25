shared_examples_for "correct user" do

  describe "when email is not present" do
    before { subject.email = '' }
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = subject.dup
      user_with_same_email.email = subject.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password doen't match confirmation" do
    before { subject.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { subject.password = subject.password_confirmation = 'a' * 5 }
    it { should_not be_valid }
  end
end
