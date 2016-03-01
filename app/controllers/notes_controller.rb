class NotesController < ApplicationController
  before_action :require_sign_in
  before_action :ensure_event, only: [:create]

  def create
    note = Note.new(note_params)
    notable = set_notable

    if note.save
      notable.notes << note
      flash[:notice] = "Note saved."
    else
      flash[:alert] = "Something went wrong, note not saved."
    end
    redirect_to company_event_path(note.event.company, note.event)
  end


  private

  def note_params
    params.require(:note).permit(:event_id, :message)
  end

  def set_notable
    if params.keys.include? "info_id"
      Info.find params[:info_id]
    end
  end

  def ensure_event
    if params[:note][:event_id].nil?
      flash[:alert] = "No event known. Please report this to Admin."
      redirect_to root_path
    end
  end
end
