class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to @board
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def index
    @boards = Board.all

    if params[:query].present?
      @boards = @boards.where('name ILIKE ? OR email ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:start_date].present? && params[:end_date].present?
      start_date = params[:start_date].to_date.beginning_of_day
      end_date = params[:end_date].to_date.end_of_day
      @boards = @boards.where(created_at: start_date..end_date)
    end

    @boards = @boards.order(created_at: :desc).page(params[:page]).per(10)
  end
  

  private

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :mines)
  end
end
