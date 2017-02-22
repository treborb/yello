def sign_up
  visit '/'
  click_link 'Sign Up'
  fill_in 'user_user_name', with: "Joe"
  fill_in 'user_email', with: 'joe@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  fill_in 'user_password_confirmation', with: 'shoobydooby'
  click_button 'Sign up'
end

def log_in
  visit '/'
  click_link 'Log In'
  fill_in 'user_email', with: 'joe@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  click_button 'Log in'
end

def sign_up_other_user
  visit '/'
  click_link 'Sign Up'
  fill_in 'user_user_name', with: "BillyBob"
  fill_in 'user_email', with: 'BillyBob@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  fill_in 'user_password_confirmation', with: 'shoobydooby'
  click_button 'Sign up'
end

def log_in_other_user
  visit '/'
  click_link 'Log In'
  fill_in 'user_email', with: 'BillyBob@example.com'
  fill_in 'user_password', with: 'shoobydooby'
  click_button 'Log in'
end

def sign_out
  visit '/'
  click_link 'Logout'
end
