class CollectionsController < ApplicationController
  before_action :find_collection, only: [:show, :edit, :update, :fill, :destroy]

  def index
    @notes = Note.where(user_id: current_user)
    @collections = Collection.where(user_id: current_user)
  end

  def show
    @notes = Note.where(collection_id: :collection_id)
  end

  def new
    @collection = current_user.collections.build
  end

  def create
      @collection = current_user.collections.build(collection_params)
      if @collection.save
        redirect_to @collection
      else
        render 'new'
      end
  end

  def edit
    @notes = Note.where(user_id: current_user)
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection
    else
      render 'edit'
    end
  end

  def fill
    @note = Note.find(params[:note_id])
    @note.collection_id = @collection.id
    @note.save
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def find_collection
    @collection = Collection.find(params[:collection_id])
  end

  def collection_params
    params.require(:collection).permit(:title)
  end
end
