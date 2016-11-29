class Tenant
  attr_accessor :tenant, :domain, :port

  def initialize(tenant, port, domain)
    @tenant = tenant
    @domain = domain
    @port = port
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

  def generated_file_path
    "generated/#{conf_file_name}"
  end

end
