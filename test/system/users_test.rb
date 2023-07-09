require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:minami)
    @new_user = { last_name: 'John',
                  first_name: 'Doe',
                  nickname: 'nickname00',
                  email: 'john_doe@rails.com',
                  password: 'password',
                  password_confirmation: 'password' }
  end

  test 'should show user details' do
    visit users_url
    assert_selector 'h1', text: 'Users'
    first_row = find('table tbody tr:first-child')
    within(first_row) do
      assert_text @user.last_name
      assert_text @user.first_name
      assert_text @user.nickname
      assert_text @user.email
    end
  end

  test 'should create a new user' do
    visit users_url
    click_on 'New'
    fill_in('user_last_name', with: @new_user[:last_name])
    fill_in('user_first_name', with: @new_user[:first_name])
    fill_in('user_nickname', with: @new_user[:nickname])
    fill_in('user_email', with: @new_user[:email])
    fill_in('user_password', with: @new_user[:password])
    fill_in('user_password_confirmation', with: @new_user[:password_confirmation])
    click_on 'Create User', match: :first
    assert_text 'User was successfully created'
  end

  test 'should update a user' do
    visit user_url(@user)
    click_on 'Edit', match: :first
    fill_in('user_last_name', with: @new_user[:last_name])
    fill_in('user_first_name', with: @new_user[:first_name])
    fill_in('user_nickname', with: 'new_nickname00')
    fill_in('user_email', with: @new_user[:email])
    fill_in('user_password', with: @new_user[:password])
    fill_in('user_password_confirmation', with: @new_user[:password_confirmation])
    click_on 'Update User'
    assert_text 'User was successfully updated'
  end

  test 'should delete a user' do
    visit user_url(@user)
    click_on 'Delete', match: :first
    assert_text 'User was successfully destroyed'
  end
end
