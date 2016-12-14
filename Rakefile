require './lib/tenant'
require './lib/tenant_generator'
require 'yaml'
require 'csv'
require 'json'

namespace :nginx do

  task default: %w[generate_all]

  desc "Generate NGINX config files for all domains"
  task :generate_all do
    config = YAML.load_file('config.yml')

    config.reject!{|key, value| key.eql?("common")}.each do |tenant_name, tenant_config|
      tenant = Tenant.new(tenant_name, tenant_config)
      TenantGenerator.generate_conf_file(tenant)
    end
    puts "Install instructions are included in the head of each these files"
  end

  desc "Generate NGINX templates"
  task :generate, [:tenant_name] do |t, args|
    config = YAML.load_file('config.yml')
    tenant_name = args[:tenant_name]
    if config.include?(tenant_name)
      tenant_config = config[tenant_name]
      tenant = Tenant.new(tenant_name, tenant_config)
      TenantGenerator.generate_conf_file(tenant)
      puts "Install instructions are included in the head of this file"
    else
      puts "Unknown tenant name: #{tenant_name}"
    end
  end

  desc "Clear existing config files"
  task :clear do
    Dir["generated/*.conf"].each do |file|
      File.delete(file)
      puts "#{file} removed"
    end
  end
end

namespace :converter do
  task default: %w[:extract_loiret]

  desc "Extract Loiret colleges to json"
  task :extract_loiret, [] do |t, args|
    filename = "DEPP-etab-1D2D"
    csv_filename = filename + ".csv"
    json_filename = filename + ".loiret.json"
    puts csv_filename
    puts json_filename
    extracted_data = CSV.table(csv_filename, col_sep: ";", encoding: "ISO8859-1")
    transformed_data = extracted_data.map { |row| row.to_hash }
    puts transformed_data.size
    wanted_data = transformed_data.select{ |row| !row[:code_postal_uai].nil? && row[:code_postal_uai] >= 45000 && row[:code_postal_uai] < 46000 && row[:denomination_principale] =~ /COLLEGE/}
    puts wanted_data.size
    File.open(json_filename, 'w+') do |file|
      file.puts JSON.pretty_generate(wanted_data)
    end
  end

  desc "Extract Yvelines colleges (only 2 actually"
  task :extract_yvelines, [] do |t, args|
    filename = "DEPP-etab-1D2D"
    csv_filename = filename + ".csv"
    json_filename = filename + ".yvelines.json"
    extracted_data = CSV.table(csv_filename, col_sep: ";", encoding: "ISO8859-1")
    transformed_data = extracted_data.map { |row| row.to_hash }
    wanted_data = transformed_data.select{ |row| !row[:patronyme_uai].nil? && (row[:patronyme_uai] =="LA VAUCOULEURS" || row[:patronyme_uai] == "LES PLAISANCES") && row[:denomination_principale] =~ /COLLEGE/}
    File.open(json_filename, 'w+') do |file|
      file.puts JSON.pretty_generate(wanted_data)
    end
  end

end

namespace :crontab do
  task default: %w[:generate]

  desc "Generate crontab line"
  task :generate, [] do
    sh 'whenever'
  end
end
