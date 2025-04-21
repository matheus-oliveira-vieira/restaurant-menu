require 'rails_helper'

describe "API::V1::Imports" do
  describe "POST /import" do
    let(:valid_json) do
      {
        "restaurants": [
          {
            "name": "Poppo's Cafe",
            "menus": [
              {
                "name": "lunch",
                "menu_items": [
                  { "name": "Burger", "price": 9.0 },
                  { "name": "Small Salad", "price": 5.0 }
                ]
              }
            ]
          }
        ]
      }.to_json
    end

    let(:invalid_json) { "{ this_is_not_valid_json: true," }

    context "with valid JSON" do
      it "returns success and logs" do
        post api_v1_import_path, params: valid_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:ok)

        parsed = JSON.parse(response.body)
        expect(parsed["success"]).to eq(true)
        expect(parsed["logs"]).to be_an(Array)
        expect(parsed["logs"].join).to include("Poppo's Cafe")
      end
    end

    context "with invalid JSON" do
      it "returns a bad_request with error message" do
        post api_v1_import_path, params: invalid_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:bad_request)

        parsed = JSON.parse(response.body)
        expect(parsed["success"]).to eq(false)
        expect(parsed["error"]).to include("Invalid JSON")
      end
    end

    context "when an unexpected error occurs" do
      before do
        allow(JsonImporter).to receive(:call).and_raise(StandardError, "Something went wrong")
      end

      it "returns an unprocessable_entity with error" do
        post api_v1_import_path, params: valid_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:unprocessable_entity)

        parsed = JSON.parse(response.body)
        expect(parsed["success"]).to eq(false)
        expect(parsed["error"]).to eq("Something went wrong")
      end
    end
  end
end
