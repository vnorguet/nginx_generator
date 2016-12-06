require './lib/tenant'
require './lib/tenant_generator'
require 'yaml'

namespace :nginx do

  task default: %w[gerenate_conf]

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
