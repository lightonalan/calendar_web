module Api
  module V1
    class AppController < ApplicationController
      skip_forgery_protection

      def info
        render json: {
          name: "Lịch Âm",
          package: "com.lighton.calendar",
          # Bump this when you ship a store build the app should prompt users to install.
          version: ENV.fetch("APP_LATEST_VERSION", "1.0.0"),
          force_update: ActiveModel::Type::Boolean.new.cast(
            ENV.fetch("APP_FORCE_UPDATE", "false")
          ),
          release_notes: ENV.fetch("APP_RELEASE_NOTES", ""),
          store_urls: {
            android: "https://play.google.com/store/apps/details?id=com.lighton.calendar",
            ios: ENV["APP_STORE_URL"].presence
          },
          support_email: ENV.fetch("SUPPORT_EMAIL", "support@lighton.app"),
          support_url: "#{request.base_url}#{support_path}",
          privacy_url: "#{request.base_url}#{privacy_path}",
          terms_url: "#{request.base_url}#{terms_path}"
        }
      end
    end
  end
end
