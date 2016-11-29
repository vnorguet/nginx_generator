require 'erb'
require 'ostruct'

class TenantGenerator
  def self.generate_conf_file(tenant)
    erb_file = "template/nginx_template.conf.erb"
    conf_file = File.basename(erb_file, '.erb')
    erb_str = File.read(erb_file)

    namespace = OpenStruct.new(tenant: tenant)

    Dir.mkdir("generated") unless Dir.exists?("generated")

    begin
      renderer = ERB.new(erb_str)
      result = renderer.result(namespace.instance_eval { binding })
      File.open(tenant.generated_file_path, 'w') do |f|
        f.write(result)
        puts "File generated: #{tenant.generated_file_path}"
      end
    rescue StandardError => e
      p e.message
      p e.backtrace
    end
  end
end
