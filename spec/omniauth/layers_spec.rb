# frozen_string_literal: true

require "spec_helper"

describe OmniAuth::Strategies::Layers do
  subject do
    OmniAuth::Strategies::Layers.new({})
  end

  context "client options" do
    it "should have correct site" do
      expect(subject.options.client_options.site).to eq("https://api.layers.digital")
    end

    it "should have correct authorize url" do
      expect(subject.options.client_options.authorize_url).to eq("https://id.layers.digital")
    end

    it "should have correct token url" do
      expect(subject.options.client_options.token_url).to eq("https://api.layers.digital/oauth/token")
    end
  end
end
