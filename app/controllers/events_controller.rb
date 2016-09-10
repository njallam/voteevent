class EventsController < ApplicationController
  def index
  end

  before_action only: [:show, :vote] do |controller|
    @event = Event.find(params[:id])
    @attendance = Attendance.find_by(event: @event, person: @person)
    @voted = @attendance.voted
    @occurred = @event.date < DateTime.now
  end

  def show
    @attendances = @event.attendances
    @votes = @attendances.where(voted: true).count
    @total = @attendances.count
  end

  def vote
    if not @voted and @occurred then
      score = params[:score].to_i
      if score > 0 and score <= 10 then
        @event.score += score
        @attendance.voted = true
        @event.save
        @attendance.save
      end
    end
  end
end
