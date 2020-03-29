class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @bills_count = @project.bills.count
    @bills_total_amount = @project.bills.calculate(:sum, :total_amount)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @bills_total_amount = @project.bills.calculate(:sum, :total_amount)
    @bills_count = @project.bills.count
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(
          :name, 'init_date(1i)', 'init_date(2i)', 'init_date(3i)', 'final_date(1i)', 'final_date(2i)', 'final_date(3i)'
      )
      {
          name: params[:project][:name],
          init_date: get_init_date(params[:project]),
          final_date: get_final_date(params[:project]),
          total: 0
      }
    end

    def get_init_date(params)
      Date.civil(params['init_date(1i)'].to_i, params['init_date(2i)'].to_i, params['init_date(3i)'].to_i)
    end

    def get_final_date(params)
      Date.civil(params['final_date(1i)'].to_i, params['final_date(2i)'].to_i, params['final_date(3i)'].to_i)
    end
end
