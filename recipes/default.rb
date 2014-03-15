include_recipe "mollyproject::setup"
include_recipe "supervisor"

default_environment = {
    'PYTHON_EGG_CACHE' => "#{node.mollyproject.install_root}/.egg-cache"
}
default_environment['PYTHONPATH'] = '/molly' if node.mollyproject.sandbox

supervisor_service "molly" do
  command "#{node.mollyproject.install_root}/bin/molly start#{"_debug" if node.mollyproject.debug} #{"-a 0.0.0.0" if node.mollyproject.bind_all}"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end

supervisor_service "mollytaskbeat" do
  command "#{node.mollyproject.install_root}/bin/molly taskbeat"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end

supervisor_service "mollytaskworker" do
  command "#{node.mollyproject.install_root}/bin/molly taskworker"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end
