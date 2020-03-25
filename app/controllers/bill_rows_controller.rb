class BillRowsController < ApplicationController
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
  end

  # GET /bill_rows/1/edit
  def edit
  end

  # POST /bill_rows
  # POST /bill_rows.json
  def create
    @bill_row = BillRow.new(bill_row_params)

    respond_to do |format|
      if @bill_row.save
        format.html { redirect_to @bill_row, notice: 'Bill row was successfully created.' }
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
        format.html { redirect_to @bill_row, notice: 'Bill row was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to bill_rows_url, notice: 'Bill row was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_row
      @bill_row = BillRow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_row_params
      params.require(:bill_row).permit(:price, :product_id, :amount)
    end
end
