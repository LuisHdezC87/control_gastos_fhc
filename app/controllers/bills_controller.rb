class BillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bill, only: [:show, :edit, :update, :destroy]


  # GET /bills
  # GET /bills.json
  def index
    @months_to_show = 4
    @current_month = get_current_month(params[:current_month], params[:prev_link], params[:next_link])
    month = Date.new(@current_month.last.to_i, @current_month.first.to_i)
    @bills = Bill.where({project: @project, purchase_date: month.beginning_of_month..month.end_of_month})
    @bills_by_month = get_bills_by_month
  end

  def get_current_month(current_month_param, prev_link_param, next_link_param)
    month = current_month_param.present? ? current_month_param.try(:split, '-') : [Date.today.month, Date.today.year]
    month = Date.new(month.last.to_i, month.first.to_i)
    if prev_link_param.present? || next_link_param.present?
      month = prev_link_param.present? ? month.prev_month(@months_to_show) : month.next_month(@months_to_show)
    end
    [month.month, month.year]
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
        set_project_total
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
        set_project_total
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
    set_project_total
    respond_to do |format|
      format.html { redirect_to project_bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_bills_by_month
    number_of_months = @months_to_show
    data = []
    while number_of_months > 0
      month = Date.new(@current_month.last.to_i, @current_month.first.to_i).prev_month(number_of_months)
      bills = Bill.where({project: @project, purchase_date: month.beginning_of_month..month.end_of_month})
      total = bills.calculate(:sum, :total_amount)
      data << {month: month, bills_count: bills.count, total: total}
      number_of_months = number_of_months - 1
    end
    data
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
          'purchase_date(1i)', 'purchase_date(2i)', 'purchase_date(3i)', :current_month
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

  def set_project_total
    @project.total = @project.bills.calculate(:sum, :total_amount)
    @project.save
  end

end
