class WelcomeController < ApplicationController
	skip_before_filter :set_customer

  def home
  end
end
