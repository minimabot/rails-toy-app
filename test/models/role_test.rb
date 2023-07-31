require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  setup do
    @role = roles(:admin)
  end

  test 'role should be valid' do
    assert @role.valid?
  end

  test 'role name should be present' do
    @role.name = ' '
    assert_not @role.valid?

    @role.name = 'present_role_name'
    assert @role.valid?
  end

  test 'role name should be unique' do
    duplicate_role = @role.dup
    assert_not duplicate_role.valid?

    duplicate_role.name = 'unique_role_name'
    assert duplicate_role.valid?
  end
end
