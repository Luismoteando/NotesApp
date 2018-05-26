class NotesController < ApplicationController
  before_action :set_note, except: [:index, :new, :create, :index_share]
  before_action :set_user, only: [:share]

  def index
    @notes = Note.where(id: (UserNote.select(:note_id).where(user_id: current_user)))
    @collections = Collection.where(id: (UserCollection.select(:collection_id).where(user_id: current_user)))
  end

  def show
    @collections = Collection.where(user_id: current_user)
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)
    @note.users << current_user
    if @note.save
      redirect_to @note
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @note
    else
      render 'edit'
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  def index_share
    @users = User.all
    @friends = current_user.friends
    @note = Note.find(params[:note_note_id])
  end

  def share
    @note.users << @user
    redirect_to request.referrer
  end

  private

  def set_note
    @note = Note.find(params[:note_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :image)
  end
end
