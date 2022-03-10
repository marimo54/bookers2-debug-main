class GroupsController < ApplicationController
  def show
    @group=Group.find(params[:id])

  end

  def index
    @groups=Group.all
    @book=Book.new
  end

  def edit
    @group=Group.find(params[:id])
    if @group.owner_id==current_user.id
      render :edit
    end
  end

  def update
    @group=Group.find(params[:id])
    @group.update(group_params)
  end


  def new
    @group=Group.new
    @group.users << current_user
  end

  def create
    @group=current_user.owner_groups.new(group_params)
    @group.owner_id=current_user.id
    if @group.save
      redirect_to groups_path
    else
    end
  end

  def join
    @group=Group.find(params[:id])
    @group.users << current_user
    redirect_to groups_path
  end

  def destroy
    @group=Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def new_mail
    @group=Group.find(params[:id])
  end

  def send_mail
    @group=Group.find(params[:id])
    group_users=@group.users
    @mail_title=params[:mail_title]
    @mail_content =params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end



  private
    def group_params
      params.require(:group).permit(:name, :introduction, :owner_id, user_ids: [] )
    end
end
