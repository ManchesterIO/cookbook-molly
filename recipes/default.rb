include_recipe "mollyproject::setup"
include_recipe "supervisor"

default_environment = {
    'PYTHON_EGG_CACHE' => "#{node.mollyproject.install_root}/.egg-cache"
}
default_environment['PYTHONPATH'] = '/molly' if node.mollyproject.sandbox

supervisor_service "mollyrest" do
  command "#{node.mollyproject.install_root}/bin/mollyrest start#{"_debug" if node.mollyproject.debug} #{"-a 0.0.0.0" if node.mollyproject.bind_all}"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end

supervisor_service "mollyui" do
  command "#{node.mollyproject.install_root}/bin/mollyui start#{"_debug" if node.mollyproject.debug} #{"-a 0.0.0.0" if node.mollyproject.bind_all}"
  user node.mollyproject.user
  environment = {
      "MOLLY_UI_SETTINGS" => node.mollyproject.ui.settings,
      "MOLLY_UI_MODULE" => node.mollyproject.ui.module
  }
  environment.update default_environment
  environment environment
end

supervisor_service "mollytaskbeat" do
  command "#{node.mollyproject.install_root}/bin/mollyrest taskbeat"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end

supervisor_service "mollytaskworker" do
  command "#{node.mollyproject.install_root}/bin/mollyrest taskworker"
  user node.mollyproject.user
  environment = { "MOLLY_CONFIG" => node.mollyproject.config }
  environment.update default_environment
  environment environment
end
