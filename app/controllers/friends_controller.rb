class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  def index
    @friends = Friend.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @friends.geocoded.map do |friend|
      {
        lat: friend.latitude,
        lng: friend.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { friend: friend }),
        image_url: helpers.asset_url('cat.png')
      }
    end
  end

  # GET /friends/1
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  def create
    @friend = Friend.new(friend_params)

    if @friend.save
      redirect_to @friend, notice: 'Friend was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /friends/1
  def update
    if @friend.update(friend_params)
      redirect_to @friend, notice: 'Friend was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /friends/1
  def destroy
    @friend.destroy
    redirect_to friends_url, notice: 'Friend was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_params
      params.require(:friend).permit(:name, :address)
    end
end
