class BillRowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bill_row, only: [:show, :edit, :update, :destroy]

  # GET /bill_rows
  # GET /bill_rows.json
  def index
    @bill_rows = BillRow.all
  end

  # GET /bill_rows/1
  # GET /bill_rows/1.json
  def show
  end

  # GET /bill_rows/new
  def new
    @bill_row = BillRow.new
    @allowed_products = Product.where(category: @project.categories).order(:name, :category_id)
  end

  # GET /bill_rows/1/edit
  def edit
    @allowed_products = Product.where(category: @project.categories).order(:name, :category_id)
  end

  # POST /bill_rows
  # POST /bill_rows.json
  def create
    @bill_row = BillRow.new(bill_row_params)

    respond_to do |format|
      if @bill_row.save
        set_bill_total_amount
        format.html { redirect_to project_bill_path(@project, @bill), notice: 'Bill row was successfully created.' }
        format.json { render :show, status: :created, location: @bill_row }
      else
        format.html { render :new }
        format.json { render json: @bill_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_rows/1
  # PATCH/PUT /bill_rows/1.json
  def update
    respond_to do |format|
      if @bill_row.update(bill_row_params)
        set_bill_total_amount
        format.html { redirect_to project_bill_path(@project, @bill), notice: 'Bill row was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill_row }
      else
        format.html { render :edit }
        format.json { render json: @bill_row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_rows/1
  # DELETE /bill_rows/1.json
  def destroy
    @bill_row.destroy
    set_bill_total_amount
    respond_to do |format|
      format.html { redirect_to project_bill_url(@project, @bill), notice: 'Bill row was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_project
      @project = Project.find(params[:project_id])
      @bill = Bill.find(params[:bill_id])
    end

    def set_bill_total_amount
      @bill.total_amount = @bill.bill_rows.calculate(:sum, :price)
      @bill.save
      @project.total = @project.bills.calculate(:sum, :total_amount)
      @project.last_update = Date.today
      @project.save
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_bill_row
      @bill_row = BillRow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_row_params
      params.require(:bill_row).permit(:price, :product_id, :amount)
      {
        bill_id: @bill.id,
        product_id: params[:bill_row][:product_id],
        price: (params[:bill_row][:price].to_i || 0),
        amount: params[:bill_row][:amount]
      }
    end
end
