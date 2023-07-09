require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      first_name: 'Doe',
      last_name: 'John',
      nickname: 'Rails',
      email: 'rails@rails.com',
      password: 'rails2023',
      password_confirmation: 'rails2023'
    )
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'first name should be present' do
    @user.first_name = ''
    assert_not @user.valid?
  end

  test 'first name should have maximum length' do
    @user.first_name = 'A' * 51
  end

  test 'last name should be present' do
    @user.last_name = ''
    assert_not @user.valid?
  end

  test 'last name should be less than maximum length' do
    @user.last_name = 'A' * 51
    assert_not @user.valid?
  end

  test 'nickname should be present' do
    @user.nickname = ''
    assert_not @user.valid?
  end

  test 'nickname should be more than minimum length' do
    @user.nickname = 'A'
    assert_not @user.valid?
  end

  test 'nickname should be less than maximum length' do
    @user.nickname = 'A' * 256
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'email should be less than maxmum length' do
    @user.email = " #{'A' * 246}@rails.com"
    assert_not @user.valid?
  end

  test 'email should be valid format' do
    valid_emails = %w[
      rails@rails.com
      RAILS@foo.COM
      R_IL-S@ra.ils.org
      rail.s@rails.jp
      rail+s@rails.cn
    ]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?
    end

    invalid_emails = %w[
      rails@rails,com
      rail_s.org
      rail.s@rails.
      rails@rail_s.com
      rails@rail+s.com
    ]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?
    end
  end

  test 'email should be unique' do
    same_email_user = @user.dup
    @user.save
    assert_not same_email_user.valid?
  end

  test 'password should be present' do
    # TODO: # rubocop:todo Style/CommentAnnotation
    # Can't assign `''` directly to password so `nil` is assigned first
    @user.password = nil
    @user.password = ''
    assert_not @user.valid?
  end

  test 'password should be more than minimum length' do
    @user.password = nil
    @user.password = 'A' * 5
    assert_not @user.valid?
  end

  test 'password should be more than maximum length' do
    @user.password = nil
    @user.password = 'A' * 256
    assert_not @user.valid?
  end

  test 'password confirmation should match' do
    @user.password_confirmation = 'rails2024'
    assert_not @user.valid?
  end
end
