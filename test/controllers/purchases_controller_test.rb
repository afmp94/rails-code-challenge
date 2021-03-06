require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  def setup
    sign_in
  end

  test "should display index page with upload form" do
    get :index
    assert_response :success
    assert_select 'input#upload'
  end

  test "should not be able to access index when not authenticated" do
    sign_out
    get :index
    assert_response :redirect
  end

  test "should display error message when no file submitted" do
    post :upload
    assert_response :redirect
    assert_equal 'Please submit a file.', flash[:alert]
  end

  test "should save data when valid tab file uploaded and display total revenue" do
    assert_difference('Purchase.count', +4) do
      assert_difference('Purchaser.count', +1) do   # 2 names match fixtures
        assert_difference('Merchant.count', +3) do
          assert_difference('Product.count', +3) do
            post :upload, upload: fixture_file_upload('files/valid_data.tab')
          end
        end
      end
    end

    assert_response :success
    assert_select 'h4.upload_success'
    assert_select 'span.total_revenue', {text: '$95.00'}
  end

  test "should save data when valid file with blank rows uploaded" do
    assert_difference('Purchase.count', +3) do
      post :upload, upload: fixture_file_upload('files/valid_data_with_blank_rows.tab')
    end

    assert_response :success
    assert_select 'h4.upload_success'
    assert_select 'span.total_revenue', {text: '$90.00'}
  end

  test "should not save data when empty file uploaded" do
    assert_no_difference('Purchase.count') do
      post :upload, upload: fixture_file_upload('files/empty.tab')
    end

    # Returns 200 but with error messages
    assert_response :success
    assert_select 'h4.upload_failure'
  end

  test "should not save data when csv file uploaded" do
    assert_no_difference('Purchase.count') do
      post :upload, upload: fixture_file_upload('files/data.csv')
    end

    assert_response :success
    assert_select 'h4.upload_failure'
  end

  test "should not save data when binary file uploaded" do
    assert_no_difference('Purchase.count') do
      post :upload, upload: fixture_file_upload('files/binary_data.png')
    end

    assert_response :success
    assert_select 'h4.upload_failure'
  end

  test "should not save data when file with invalid data uploaded" do
    assert_no_difference('Purchase.count') do
      post :upload, upload: fixture_file_upload('files/invalid_data.tab')
    end

    assert_response :success
    assert_select 'h4.upload_failure'
  end
end
