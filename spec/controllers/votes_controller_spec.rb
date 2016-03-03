require 'rails_helper'

RSpec.describe VotesController, :type => :controller do

  shared_examples "a notifier" do
    it "calls VoteMailer with the right method" do
      expect(VoteMailer).to receive(:respond_to?).with(method_name)
      post :create, movie_id: movie.id, t: vote_type
    end

    xit "delays a mailer job" do
      expect(VoteMailer.instance_method method_name).to be_delayed movie, user
    end
  end

  describe "POST create" do
    let(:user) { User.create(:name => "Test", :email => "test@test.com") }
    let(:movie) { Movie.create(title: "A Movie", description: "Description", date: Date.today) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      expect(controller).to receive(:authorize!).and_return(true)
    end

    context "user submits a 'like' vote" do
      let(:vote_type) { "like" }
      let(:method_name) { :like_email }
      it_behaves_like "a notifier"
    end

    context "user submits a 'hate' vote" do
      let(:vote_type) { "hate" }
      let(:method_name) { :hate_email }
      it_behaves_like "a notifier"
    end
  end

end
