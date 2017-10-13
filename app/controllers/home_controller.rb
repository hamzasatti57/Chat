class HomeController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

def search
	@users = User.search(params[:name])
  @users = if params[:name]
    user.where('name LIKE ?', "%#{params[:name]}%")
  else
    user.all
  end
end

end
