require "omniauth/strategies/oauth2"

module OmniAuth
  module Strategies
    class Layers < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end
      USER_INFO_URL = 'https://api.layers.digital/v1/oauth/user/info'
      ACCOUNT_INFO_URL = 'https://api.layers.digital/v1/oauth/account/info'

      option :name, :layers

      option :client_options, {
        site: "https://api.layers.digital",
        authorize_url: "https://id.layers.digital",
        token_url: "https://api.layers.digital/oauth/token"
      }

      option :authorize_params, {
        scope: "openid fullname email related.communities"
      }

      def build_access_token
        code = request.params["code"]
        token_params = {
          client_id: client.id,
          redirect_uri: callback_url
        }
        client.auth_code.get_token(code, token_params, deep_symbolize(options.auth_token_params))
      end

      uid { raw_info["id"].to_s }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
          communities: raw_info["communities"]
        }
      end

      extra do
        {
          account_info: raw_info,
          user_info: user_info(raw_info)
        }
      end

      def raw_info
        @raw_info ||= access_token.get("#{ACCOUNT_INFO_URL}?includes=communities").parsed || {}
      end

      def user_info(raw_info)
        communities_user_info = []
        raw_info["communities"]&.each do |community|
          user_info = access_token.get("#{USER_INFO_URL}?_community=#{community.community}&includes=communities").parsed || {}
          communities_user_info << user_info
        end
        communities_user_info
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end
    end
  end
end

OmniAuth.config.add_camelization 'layers', 'Layers'
