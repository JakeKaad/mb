require 'rails_helper'

describe NotesController do
  include ControllerMacros

  describe "POST create" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info) { create :info, event: event }
    let(:note_params) { attributes_for :note }



    context "success -info" do
      before do
        login user
        note_params[:event_id] = event.id
        post :create, info_id: info.id, note: note_params
      end

      it "should create a note" do
        expect(Note.all).to_not be_empty
      end

      it "should display a success message" do
        expect(flash[:notice]).to_not be_empty
      end

      it "should redirect_to event show page" do
        expect(response).to redirect_to company_event_path company, event
      end

      it "should set the notable" do
        expect(info.notes).to_not be_empty
      end
    end

    context "failure - No message" do
      before do
        login user
        post :create, info_id: info.id, note: { event_id: event.id }
      end

      it "should redirect_to event show page" do
        expect(response).to redirect_to company_event_path company, event
      end

      it "shouldn't create a note with no message" do
        expect(Note.all).to be_empty
      end

      it "should display a failure message" do
        expect(flash[:alert]).to_not be_empty
      end
    end

    context "failure- No event_id" do
      before do
        login user
        post :create, info_id: info.id, note: note_params
      end

      it "shouldn't create a note with no event_id" do
        expect(Note.all).to be_empty
      end

      it "should display a failure message" do
        expect(flash[:alert]).to include "No event known. Please report this to Admin."
      end

      it "should redirect_to root_path with no event" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
