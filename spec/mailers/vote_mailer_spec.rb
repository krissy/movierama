require 'rails_helper'

RSpec.describe VoteMailer do

  SENDER_EMAIL = ['notifications@movierama.com']

  let(:voter) { double("User", name: "Sam Sparks") }
  let(:submitter) { double("User", name: "Steve", email: "steve@moustache.com") }
  let(:movie) { double("Movie", title: "Cloudy With a Chance of Meatballs", user: submitter) }

  shared_examples "a vote mailer" do
    it 'renders the subject' do
      expect(mail.subject).to eql(subject)
    end

    it 'renders the correct from address' do
      expect(mail.from).to eql(SENDER_EMAIL)
    end

    it 'renders the correct headings in multipart content' do
      if mail.parts.size > 0
        mail.parts.each do |part|
          expect(part.body).to include(heading)
        end
      end
    end
  end

  describe 'like_email' do
    let(:mail) { VoteMailer.like_email(movie, voter) }
    let(:subject) { "Your movie was liked!" }
    let(:heading) { "#{voter.name} likes your movie!" }

    it_behaves_like "a vote mailer"
  end

  describe 'hate_email' do
    let(:mail) { VoteMailer.hate_email(movie, voter) }
    let(:subject) { "Your movie was hated!" }
    let(:heading) { "#{voter.name} is a bit of a hater!" }

    it_behaves_like "a vote mailer"
  end

end
