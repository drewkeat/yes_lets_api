class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :update, :destroy]

  # GET /friendships
  def index
    @friendships = Friendship.all

    render json: FriendshipSerializer.new(@friendships)
  end

  # GET /friendships/1
  def show
    render json: FriendshipSerializer.new(@friendship)
  end

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      @user = User.find(@friendship.user_id)
      @user.friendships << @friendship
      @user.save
      @friend = User.find(@friendship.friend_id)
      @friend.friendships << @friendship
      @friend.save
      render json: FriendshipSerializer.new(@friendship), status: :created, location: @friendship
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /friendships/1
  def update
    if @friendship.update(friendship_params)
      render json: FriendshipSerializer.new(@friendship)
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship.destroy
    render json: FriendshipSerializer.new(@friendship)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:id, :user_id, :friend_id, :status)
    end
end
