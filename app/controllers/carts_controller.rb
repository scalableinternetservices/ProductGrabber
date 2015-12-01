include CartsHelper

class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :like_sort, :price_sort, :time_sort, :search, :init]
  before_action :logged_in_user

  # GET /carts
  # GET /carts.json
  def index
    if stale?([Cart.all, LineItem.all])
      @carts = Cart.all
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    fresh_when([@cart, @cart.line_items])
    @cart.count_load(0)
  end

  # GET /carts/new
  def new
    @cart = Cart.new if stale?(Cart.all)
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = current_cart

    #@cart.line_items.sort!{|a,b|a.updated_at <=> b.updated_at}

    respond_to do |format|
      if @cart.save
        format.html { redirect_to init_cart_path(@cart), notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = current_cart
    @cart.get_items(nil)
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Your cart has been empty'}
      format.json { head :no_content }
    end
  end

  def price_sort
    @cart.get_items(@cart.items.sort {|a,b| a.product.price <=> b.product.price}) if !@cart.items.nil?
    redirect_to @cart
  end

  def like_sort
    #@cart.get_items(@cart.cur_items.sort {|a,b| a.product.favorites.count <=> b.product.favorites.count}.reverse)
    @cart.get_items(@cart.items.sort {|a,b| a.product.favorites.count <=> b.product.favorites.count}.reverse) if !@cart.items.nil?
    redirect_to @cart
  end

  def time_sort
    @cart.get_items(@cart.items.sort {|a,b| a.updated_at <=> b.updated_at}.reverse) if !@cart.items.nil?
    redirect_to @cart
  end

  def init
    @cart.get_items(nil)
    @cart.get_items(@cart.line_items)
    @cart.get_re_products(nil)
    redirect_to time_sort_cart_path(@cart)
  end

  def search
    @cart.get_items(@cart.category[params[:key]])
    p=Product.all
    @hash=p.group_by{|p| p.category}
    @cart.get_re_products(@hash[params[:key]])
    redirect_to @cart
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params[:cart]
  end
end
