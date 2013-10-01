include_recipe "mollyproject::setup"
include_recipe "supervisor"

supervisor_service "mollyrest" do
  command "#{node.mollyproject.install_root}/bin/mollyrest"
  user node.mollyproject.user
  environment "MOLLY_CONFIG" => node.mollyproject.config
end

supervisor_service "mollyui" do
  command "#{node.mollyproject.install_root}/bin/mollyui"
  user node.mollyproject.user
  environment "MOLLY_UI_SETTINGS" => node.mollyproject.ui.settings,
              "MOLLY_UI_MODULE" => node.mollyproject.ui.module
end

supervisor_service "mollytaskbeat" do
  command "#{node.mollyproject.install_root}/bin/mollyrest taskbeat"
  user node.mollyproject.user
  environment "MOLLY_CONFIG" => node.mollyproject.config
end

supervisor_service "mollytaskworker" do
  command "#{node.mollyproject.install_root}/bin/mollyrest taskworker"
  user node.mollyproject.user
  environment "MOLLY_CONFIG" => node.mollyproject.config
end
