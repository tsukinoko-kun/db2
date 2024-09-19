class ApplicationController < ActionController::Base
  before_action :setup_cors

  # Called for CORS OPTIONS request
  # see https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
  def options
    head :no_content
  end

  private
  def setup_cors
    headers["Access-Control-Allow-Origin"] = "http://localhost:4000"
    headers["Access-Control-Allow-Methods"] = "GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD"
    headers["Access-Control-Allow-Headers"] = "Origin,X-Requested-With,Content-Type,Accept,Authorization"
    headers["Access-Control-Allow-Credentials"] = "true"
  end
end
