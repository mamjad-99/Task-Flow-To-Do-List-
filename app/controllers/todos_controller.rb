class TodosController < ApplicationController
  
  before_action :set_todo, only: %i[show edit update destroy mark_done]
  before_action :correct_user, only: %i[edit update destroy mark_done]

  def index
    @todos = Todo.all
  end

  def show; end

  def new
    @todo = current_user.todos.build
  end

  def edit; end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy!
    redirect_to todos_path, notice: "Todo was successfully destroyed.", status: :see_other
  end

  def mark_done
    @todo.update(status: true)
    redirect_to @todo, notice: "Todo marked as completed!"
  end

  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
    redirect_to root_path, notice: "Not Authorized To Edit This To Do" if @todo.nil?
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:task, :date, :time, :status, :title, :user_id)
  end
end
