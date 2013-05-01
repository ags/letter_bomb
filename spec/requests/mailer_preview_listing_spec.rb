require 'spec_helper'

describe 'Listing Previews' do
  it "should list each preview and its actions" do
    get '/'
    expect(response.body).to include 'FooMailerPreview'
    expect(response.body).to include 'bad'
    expect(response.body).to include 'good'
  end
end
