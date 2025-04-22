class Api::V1::ImportsController < ApplicationController
  def create
    json_data = JSON.parse(request.body.read)
    logs = JsonImporter.call(json_data) # calls JsonImporter service
    render json: { success: true, logs: logs }, status: :ok

  rescue JSON::ParserError => e
    render json: { success: false, error: "Invalid JSON: #{e.message}" }, status: :bad_request
  rescue => e
    render json: { success: false, error: e.message }, status: :unprocessable_entity
  end
end
