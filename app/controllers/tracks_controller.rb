class TracksController < ApplicationController
  def new
    @track = Track.new(album_id: params[:album_id])
    @album = Album.find(params[:album_id])

    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save!
      redirect_to album_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  def edit
    @track = Track.find(params[:id])

    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to bands_url
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :ord, :lyrics)
  end
end
