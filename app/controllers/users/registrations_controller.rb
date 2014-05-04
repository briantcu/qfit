class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create]

  def create
    super
  end

  #Returns form
  def new
    super
  end

end