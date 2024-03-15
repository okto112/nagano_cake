class Admin::ItemsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    if params[:item_name] != nil
      @items = Item.where("name LIKE ?", "%#{params[:item_name]}%").page(params[:page])
      @genres = Genre.all
    else
      @items = Item.page(params[:page])
      @genres = Genre.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      @item = Item.new
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end
end
