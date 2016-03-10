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

    context "success - customer" do
      let(:customer) { create :customer}

      before do
        login user
        note_params[:event_id] = event.id
        post :create, customer_id: customer.id, note: note_params
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

      it "should assign @notable" do
        expect(assigns(:notable)).to eq customer
      end

      it "should set the notable" do
        expect(customer.notes).to_not be_empty
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

  describe "get edit" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info) { create :info, event: event }
    let(:note) { create :note, notable: info, event: event }

    before do
      login user
      get :edit, info_id: info.id, id: note.id
    end

    it "should assign @notable" do
      expect(assigns(:notable)).to eq info
    end

    it "should assign @note" do
      expect(assigns(:note)).to eq note
    end

    it "should redirect back with an html" do
      expect(response).to redirect_to root_path
    end
  end

  describe "POST update" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:user) { create :user }
    let(:info) { create :info, event: event }
    let(:note) { create :note, notable: info, event: event }


    context "info note" do
      before do
        login user
        post :update, info_id: info.id, id: note.id, note:  { message: "Updated notes" }
      end

      it "should assign @notable" do
        expect(assigns(:notable)).to eq info
      end

      it "should assign @note" do
        expect(assigns(:note)).to eq note
      end

      it "should update @note" do
        expect(note.reload.message).to eq "Updated notes"
      end

      it "should redirect back with an html" do
        expect(response).to redirect_to root_path
      end
    end

    context "customer note" do
      let(:customer) { create :customer }

      before do
        login user
        post :update, customer_id: customer.id, id: note.id, note:  { message: "Updated notes" }
      end

      it "should assign @notable" do
        expect(assigns(:notable)).to eq customer
      end

      it "should assign @note" do
        expect(assigns(:note)).to eq note
      end

      it "should update @note" do
        expect(note.reload.message).to eq "Updated notes"
      end

      it "should redirect back with an html" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET new" do
    let(:company) { user.company }
    let(:event) { create :event, company: company }
    let(:info) { create :info, event: event }
    let(:user) { create :user }
    let(:customer) { create :customer }

    before do
      login user
      event.customers << customer
      get :new, customer_id: customer.id, event_id: event.id
    end

    it "should assign @event" do
      expect(assigns(:event)).to eq event
    end

    it "should set @notable as customer when its customer" do
      expect(assigns(:notable)).to eq customer
    end

    it "should assign @note" do
      expect(assigns(:note).new_record?).to be_truthy
      expect(assigns(:note).class).to eq Note
    end
  end
end
