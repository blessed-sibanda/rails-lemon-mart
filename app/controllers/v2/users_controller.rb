class V2::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    page = params[:page] || 1
    search_text = params[:filter]
    sort_key = params[:sort]

    if search_text
      @users = User.search(search_text).paginate(page: page)
    elsif sort_key
      allowed_sort_fields = ["email", "first_name", "last_name", "middle_name"]
      sort_order = sort_key.starts_with?("-") ? :desc : :asc
      sort_key = sort_key[1..-1] if sort_key.starts_with?("-")
      unless allowed_sort_fields.include? sort_key
        render json: {
          error: "'#{sort_key}' is not a valid sort field",
        }, status: 400
      end
      @users = User.paginate(page: page).order({ sort_key => sort_order })
    else
      @users = User.paginate(page: page).order(:created_at)
    end
  end

  def show
    @user = User.find params[:id]
    unless (current_user.role == User::MANAGER || @user == current_user)
      render json: { error: "Only the manager or the profile owner can access user details" }, status: 403
    end
  end

  def me
    @user = current_user
  end
end
