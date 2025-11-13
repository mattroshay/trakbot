class TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :edit, :update, :destroy]

  def index
    @trackers = current_user.trackers.order(created_at: :desc)
  end

  def show
  end

  def new
    @tracker = Tracker.new
  end

  def create
    @tracker = current_user.trackers.build(tracker_params)
    if @tracker.save
      redirect_to @tracker, notice: 'Tracker was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tracker.update(tracker_params)
      redirect_to @tracker, notice: 'Tracker was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tracker.destroy
    redirect_to trackers_path, notice: 'Tracker was successfully deleted.'
  end

  private

  def set_tracker
    @tracker = current_user.trackers.find(params[:id])
  end

  def tracker_params
    params.require(:tracker).permit(:link, :description, :keywords)
  end
end
