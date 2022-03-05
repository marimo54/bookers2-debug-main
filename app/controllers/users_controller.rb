class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user_id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    now = Time.current
    #@today_books = @books.where(created_at: now.all_day).count
    #@yesterday_books = @books.where(created_at: now.prev_day.all_day).count
    #@this_week_books = @books.where(created_at: now.all_week).count
    #@last_week_books = @books.where(created_at: now.prev_week.all_week).count
    #if @yesterday_books == 0
      #@ratio1 = 0
    #else
      #@ratio1 = @today_books/@yesterday_books.to_f
    #end
    #if @last_week_books == 0
      #@ratio2 = 0
    #else
      #@ratio2 = @this_week_books/@last_week_books.to_f
    #end
    day1=now.prev_day
    day2=day1.prev_day
    day3=day2.prev_day
    day4=day3.prev_day
    day5=day4.prev_day
    day6=day5.prev_day
    @today_books=@books.where(created_at: now.all_day).count
    @day1_books=@books.where(created_at: day1.all_day).count
    @day2_books=@books.where(created_at: day2.all_day).count
    @day3_books=@books.where(created_at: day3.all_day).count
    @day4_books=@books.where(created_at: day4.all_day).count
    @day5_books=@books.where(created_at: day5.all_day).count
    @day6_books=@books.where(created_at: day6.all_day).count
    @q=@user.books.ransack(params[:q])
    @results= @q.result(distinct: true).order(created_at: "desc").count
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id==current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @title = "Follow Users"
    user = User.find(params[:id])
    @users = user.following
    render 'show_follow'
  end

  def followers
    @title = "Follower Users"
    user = User.find(params[:id])
    @users = user.follower
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
