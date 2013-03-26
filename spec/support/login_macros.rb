module LoginMacros
  def set_user_session(user)
    session[:user_id] = controller.stub(:current_user) { user }
  end

  def sign_in(user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end
end