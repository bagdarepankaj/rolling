class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:new, :index, :create]
  before_action :find_user, only: [:add_user, :remove_user]

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def show
    @employees = User.where(organization_id: @organization.id)
  end

  def add_user
    @user.update(organization_id: @organization.id)
    @user.add_role :employee
    respond_to do |format|
      format.html { redirect_to organization_path(@organization), notice: 'User Added Sucessfully' }
      format.js
    end
  end

  def remove_user
    @user.update(organization_id: nil)
    @user.remove_role :employee
    respond_to do |format|
      format.html { redirect_to organization_path(@organization), notice: 'User Removed Sucessfully' }
      format.js
    end
  end

  def create
    @organization =  current_user.build_organization(organization_params)
    if @organization.save
      redirect_to organization_path(@organization), notice: 'Organization Sucessfully Created'
    else
      redirect_to organizations_path, alert: 'Something went wrong'
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path(@organization), notice: 'Organization Sucessfully Updated'
    else
      redirect_to organizations_path, alert: 'Something went wrong'
    end
  end

  def users_list
    @users = User.where(organization_id: nil)
    respond_to do |format|
      format.js
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description)
  end

  def set_organization
    id = params[:id] || params[:organization_id]
    @organization = Organization.find_by(id: id)
    redirect_to organizations_path, alert: 'Organization not Found' unless @organization
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
    unless @user.present?
      redirect_to organization_path(@organization), alert: "User is not in records"
    end
  end
end
