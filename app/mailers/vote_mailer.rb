class VoteMailer < ActionMailer::Base
  SENDER = "notifications@movierama.com"
  default from: SENDER

  def like_email(movie, voter)
    _vote_info(movie, voter)
    # TODO Consider I18n locales
    mail(to: @submitter.email, subject: 'Your movie was liked!')
  end

  def hate_email(movie, voter)
    _vote_info(movie, voter)
    mail(to: @submitter.email, subject: 'Your movie was hated!')
  end


  private

  def _vote_info(movie, voter)
    @movie = MovieDecorator.new(movie)
    @submitter = UserDecorator.new(movie.user)
    @voter = voter
  end

end
