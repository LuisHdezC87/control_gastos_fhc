class BillsController < ApplicationController
  before_action :set_project
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = @project.bills
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bill_rows = @bill.bill_rows
    @bill_row = BillRow.new
    @bill_row.amount = 1
    @allowed_products = Product.where(category: @project.categories).order(:name, :category_id)
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
    @allowed_products = Product.where(category: @project.categories).order(:name, :category_id)
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to project_bill_path(@project, @bill), notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to project_bill_path(@project, @bill), notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to project_bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
      @allowed_project_contacts = Contact.all
      @allowed_project_bill_types = @project.bill_types
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(
          :project_id, :total_amount, :purchase_date, :contact_id, :bill_type_id,
          'purchase_date(1i)', 'purchase_date(2i)', 'purchase_date(3i)'
      )
      {
         project_id: @project.id,
         purchase_date: get_date(params[:bill]),
         contact_id: params[:bill][:contact_id],
         bill_type_id: params[:bill][:bill_type_id]
      }
    end

    def get_date(params)
      Date.civil(params['purchase_date(1i)'].to_i, params['purchase_date(2i)'].to_i, params['purchase_date(3i)'].to_i)
    end
end
