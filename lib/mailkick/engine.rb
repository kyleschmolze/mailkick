module Mailkick
  class Engine < ::Rails::Engine
    isolate_namespace Mailkick

    require_relative '../../app/helpers/mailkick/url_helper'

    initializer "mailkick" do |app|
      Mailkick.discover_services unless Mailkick.services.any?
      secrets = app.respond_to?(:secrets) ? app.secrets : app.config
      Mailkick.secret_token ||= secrets.respond_to?(:secret_key_base) ? secrets.secret_key_base : secrets.secret_token
      ActiveSupport.on_load :action_mailer do
        helper Mailkick::UrlHelper
      end
    end
  end
end
