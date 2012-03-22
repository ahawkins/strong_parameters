require 'test_helper'

class BooksController < ActionController::Base
  def create
    params.required(:book).required(:name)
    head :ok
  end
end

class ActionControllerRequiredParamsTest < ActionController::TestCase
  tests BooksController
  
  test "missing required parameters will raise exception" do
    post :create, { magazine: { name: "Mjallo!" } }
    assert_response :bad_request

    post :create, { book: { title: "Mjallo!" } }
    assert_response :bad_request
  end

  test "missing required parameters will be included in the respone" do
    post :create, { magazine: { name: "Mjallo!" } }
    assert_match /book/, response.body
  end
  
  test "required parameters that are present will not raise" do
    post :create, { book: { name: "Mjallo!" } }
    assert_response :ok
  end
end
