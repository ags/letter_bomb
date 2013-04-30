require 'spec_helper'

describe 'Listing Previews' do
  it "should list each preview and its actions" do
    get '/'
    expect(response.body).to include 'UserMailer'
    expect(response.body).to include 'welcome'
  end
end
