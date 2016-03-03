class VotesController < ApplicationController
  after_action :_notify_submitter, only: [:create]

  def create
    authorize! :vote, _movie

    _voter.vote(_type)
    redirect_to root_path, notice: 'Vote cast'
  end

  def destroy
    authorize! :vote, _movie

    _voter.unvote
    redirect_to root_path, notice: 'Vote withdrawn'
  end

  private

  def _notify_submitter
    return unless %i{like hate}.include?(_type)
    method_name = "#{_type.to_s}_email".to_sym
    VoteMailer.delay.send(method_name, _movie, current_user) if VoteMailer.respond_to? method_name
  end

  def _voter
    VotingBooth.new(current_user, _movie)
  end

  def _type
    case params.require(:t)
    when 'like' then :like
    when 'hate' then :hate
    else raise
    end
  end

  def _movie
    @_movie ||= Movie[params[:movie_id]]
  end
end
