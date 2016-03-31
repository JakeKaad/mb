FactoryGirl.define do
  factory :menu do
    event
    service_style "Buffet"
    rate_type "Per person"
    base_rate 30
    final_price 35
  end
end
