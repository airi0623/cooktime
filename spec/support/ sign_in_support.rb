module SignInSupport
  def sign_in(user)
    visit root_path
    fill_in 'クリックして画像をアップロード', with: @user.icon
    fill_in 'ニックネーム', with: @user.nickname
    fill_in 'プロフィール', with: @user.profile
    fill_in 'お名前(全角)', with: @user.famile_name
    fill_in 'お名前(全角)', with: @user.first_name
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    fill_in 'パスワード(確認用)', with: @user.password_confirmation
    click_on("Log in")
    expect(current_path).to eq root_path
  end
end