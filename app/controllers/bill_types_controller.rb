class BillTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bill_type, only: [:show, :edit, :update, :destroy]

  # GET /bill_types
  # GET /bill_types.json
  def index
    @bill_types = @project.bill_types
  end

  # GET /bill_types/1
  # GET /bill_types/1.json
  def show
  end

  # GET /bill_types/new
  def new
    @bill_type = BillType.new
  end

  # GET /bill_types/1/edit
  def edit
  end

  # POST /bill_types
  # POST /bill_types.json
  def create
    @bill_type = BillType.new(bill_type_params)

    respond_to do |format|
      if @bill_type.save
        format.html { redirect_to project_bill_type_path(@project, @bill_type), notice: 'Bill type was successfully created.' }
        format.json { render :show, status: :created, location: @bill_type }
      else
        format.html { render :new }
        format.json { render json: @bill_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_types/1
  # PATCH/PUT /bill_types/1.json
  def update
    respond_to do |format|
      if @bill_type.update(bill_type_params)
        format.html { redirect_to  project_bill_type_path(@project, @bill_type), notice: 'Bill type was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill_type }
      else
        format.html { render :edit }
        format.json { render json: @bill_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_types/1
  # DELETE /bill_types/1.json
  def destroy
    @bill_type.destroy
    respond_to do |format|
      format.html { redirect_to project_bill_types_url(@project), notice: 'Bill type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_bill_type
      @bill_type = BillType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_type_params
      params.require(:bill_type).permit(:project_id, :description, :name)
      {
          project_id: @project.id,
          description: params[:description],
          name: params[:name]
      }
    end
end
