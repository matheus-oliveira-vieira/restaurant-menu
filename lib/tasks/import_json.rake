namespace :import do
  desc "Importa menus de um JSON"
  task json: :environment do
    file_path = ENV["FILE"] || "app/data/restaurant_data.json"

    unless File.exist?(file_path)
      puts "File not found: #{file_path}"
      exit(1)
    end

    begin
      json_data = JSON.parse(File.read(file_path))
      logs = JsonImporter.call(json_data)

      puts "Import completed successfully!"
      logs.each { |log| puts log }
    rescue JSON::ParserError => e
      puts "Invalid JSON: #{e.message}"
    rescue => e
      puts "Unexpected error: #{e.message}"
    end
  end
end

# Run rails import:json
