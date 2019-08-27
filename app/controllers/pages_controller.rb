class PagesController < ApplicationController

  def home
  end

  def dashboard
    @user = current_user
    @bookings = @user.bookings
    @posts = @user.posts
  end
end
