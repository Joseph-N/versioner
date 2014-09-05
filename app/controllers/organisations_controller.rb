class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.all
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.create(organisation_params)
    if @organisation.save
      redirect_to organisations_path, :notice => "Organisation was successfully created"
    else
      render 'new'
    end
  end

  def show
    @organisation = Organisation.find(params[:id])
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name)
  end
end
