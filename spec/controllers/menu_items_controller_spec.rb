require 'rails_helper'

describe MenuItemsController do
  include ControllerMacros

  describe "POST create" do
    context "with existing menu option" do
      let(:menu) { create :menu }
      let(:option) { create :menu_option }

      before do
        login
        post :create, params: {
                                menu_id: menu.id,
                                menu_item: {
                                  menu_option_id: option.id,
                                  course: option.suggested_course,
                                  price_adjustment: option.suggested_price_adjustment
                                }
                              }
      end

      it "sets @menu" do
        expect(assigns(:menu)).to eq menu
      end

      it "creates a menu_item" do
        expect(MenuItem.count).to eq 1
      end

      it "redirects back" do
        request.env["HTTP_REFERER"] = root_path
        expect(response).to redirect_to root_path
      end

      it "sets a notice" do
        expect(flash[:notice]).to_not be_empty
      end

      it "increases the final price of the menu when added" do
        expect(menu.reload.final_price - menu.base_rate).to eq option.suggested_price_adjustment
      end
    end
  end


  context "invalid" do
    let(:menu) { create :menu }
    let!(:menu_item) { create :menu_item, menu_option: option, menu: menu}
    let(:option) { create :menu_option }

    before do
      login
      post :create, params: {
                              menu_id: menu.id,
                              menu_item: {
                                menu_option_id: option.id,
                                course: option.suggested_course,
                                price_adjustment: option.suggested_price_adjustment
                              }
                            }
    end

    it "sets @menu" do
      expect(assigns(:menu)).to eq menu
    end

    it "doesn't create a menu_item" do
      expect(MenuItem.count).to eq 1
    end

    it "redirects back" do
      request.env["HTTP_REFERER"] = root_path
      expect(response).to redirect_to root_path
    end

    it "sets an alert" do
      expect(flash[:alert]).to_not be_empty
    end
  end
end
