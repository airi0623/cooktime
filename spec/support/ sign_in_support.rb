module SignInSupport
  def sign_in(user)
    attach_file('user[icon]', icon_path, make_visible: true)
    fill_in 'user-nickname', with: @user.nickname
    fill_in 'user-profile', with: @user.profile
    fill_in 'user-family', with: @user.family_name
    fill_in 'user-first', with: @user.first_name
    fill_in 'user-email', with: @user.email
    fill_in 'user-password', with: @user.password
    fill_in 'user-password-confirmation', with: @user.password_confirmation
  end
end