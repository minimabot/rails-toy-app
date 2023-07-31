require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  setup do
    @permission = permissions(:create_user)
  end

  test 'permission should be valid' do
    assert @permission.valid?
  end

  test 'permission name should be present' do
    @permission.name = ' '
    assert_not @permission.valid?

    @permission.name = 'present_permission_name'
    assert @permission.valid?
  end

  test 'permission name should be unique' do
    dupicate_permission = @permission.dup
    assert_not dupicate_permission.valid?

    dupicate_permission.name = 'unique_permission_name'
    assert dupicate_permission.valid?
  end
end
