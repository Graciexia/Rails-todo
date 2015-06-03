class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def show
    begin

      render json: Todo.find(params[:id])

      rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: 404

      rescue StandardError => error
      render json: { error: error.message }, status: 422
    end
  end

  def new
    render json: "There is nothing here."
  end

  def create
    begin
      todo = Todo.create(todo: params[:todo])
      render json: todo
      rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end

  def destroy
    if Todo.exists?(params[:id])
      Todo.destroy(params[:id])
      render json: { message: 'destroyed' }, status: 200
    else
      render json: { error: 'Todo not found' }, status: 404
    end
  end



end
