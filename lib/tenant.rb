class Tenant
  attr_accessor :tenant, :domain, :port, :timestamp, :enable_ssl, :enable_stage, :www_to_not_www

  def initialize(tenant, config)
    @tenant = tenant
    @domain = config['domain']
    @port = config['port']
    @enable_ssl = config['enable_ssl']
    @enable_stage = config['enable_stage']
    @www_to_not_www = config['www_to_not_www']
    @timestamp = Time.now.to_i
  end

  def stage
    "#{tenant}.stage.#{domain}"
  end

  def stage_upstream
    "stage_#{tenant}"
  end

  def stage_port
    4000 + port
  end

  def prod
    "#{tenant}.#{domain}"
  end

  def prod_upstream
    "prod_#{tenant}"
  end

  def prod_port
    3000 + port
  end

  def conf_file_name
    "#{tenant}.conf"
  end

  def timestamped_conf_file_name
    "#{tenant}.#{timestamp}.conf"
  end

  def generated_file_path
    "generated/#{timestamped_conf_file_name}"
  end

  def enable_stage?
    enable_stage
  end

  def enable_ssl?
    enable_ssl
  end

  def www_to_not_www?
    www_to_not_www
  end

end
