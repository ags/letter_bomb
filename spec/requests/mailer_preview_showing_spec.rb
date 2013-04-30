require 'spec_helper'

describe 'Showing a Preview' do
  it "renders the 'from' address" do
    get '/UserMailer::Preview/welcome'
    expect(response.body).to include 'bar@example.com'
  end

  it "renders the 'to' address" do
    get '/UserMailer::Preview/welcome'
    expect(response.body).to include 'foo@example.com'
  end

  it "renders the subject" do
    get '/UserMailer::Preview/welcome'
    expect(response.body).to include 'welcome to the show!'
  end

  it "renders the mailer body" do
    get '/UserMailer::Preview/welcome'
    expect(response.body).to include 'a mailer var: john'
  end
end
