include_recipe "mollyproject::setup"

python_pip "git+https://github.com/ManchesterIO/mollyproject-next.git" do
  virtualenv node.mollyproject.install_root
  user node.mollyproject.user
  group node.mollyproject.user
  action :upgrade
end