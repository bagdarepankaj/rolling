class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :set_organization

  # GET /projects or /projects.json
  def index
    @projects = @organization.projects
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = @organization.projects.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    # @project = Project.new(project_params)
    @project = @organization.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to organization_project_url(@organization, @project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to organization_project_url(@organization, @project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Find organization first
    def set_organization
      @organization = Organization.find_by(id: params[:organization_id])
      redirect_to organizations_path, alert: 'Organization not Found' unless @organization
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :organizations_id)
    end
end
