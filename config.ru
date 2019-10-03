require 'dashing'

configure do
  set :auth_token, 'FOO'
  set :template_languages, %i[html erb]
  enable :sessions

  helpers do
    def protected!
      if session.include?('auth_token') && authenticated?(session['auth_token'])
        return
      end
      unless authenticated?(params['token'])
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
      session['auth_token'] = params['token']
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
