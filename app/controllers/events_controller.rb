class EventsController < ApplicationController
  def index
  end

  before_action only: [:show, :alt, :vote, :reveal] do |controller|
    @event = Event.find(params[:id])
    @attendance = Attendance.find_by(event: @event, person: @person)
    @guest = !@attendance.nil?
    if @guest then
      @voted = @attendance.voted
      @occurred = @event.date < DateTime.now
    end
  end

  before_action only: [:show, :alt, :reveal] do |controller|
    @attendances = @event.attendances
    @votes = @attendances.where(voted: true).count
    @total = @attendances.count
    @revealed = @event.revealed
    @voting_complete = @votes == @total
  end

  def show
    if @revealed
      @score = @event.score
      @average = @score/@total
    end
  end

  def alt
  end

  def vote
    unless @guest then
      @person = Person.find_by(passcode: params[:passcode])
      @attendance = Attendance.find_by(event: @event, person: @person)
      @guest = !@attendance.nil?
      if @guest then
        @voted = @attendance.voted
        @occurred = @event.date < DateTime.now
      end
    end
    if @guest and not @voted and @occurred then
      score = params[:score].to_i
      if score > 0 and score <= 10 then
        @event.score += score
        @attendance.voted = true
        @event.save
        @attendance.save
      end
    end
  end

  def reveal
    if not @revealed and @guest and @voting_complete
      @event.revealed = true
      @event.save
    end
    redirect_to @event
  end
end
