include_recipe "build-essential"
include_recipe "git"
include_recipe "python"

user node.mollyproject.user do
  home node.mollyproject.install_root
end

%w(build-essential libgeos-c1 libprotobuf-dev protobuf-compiler).each { | package | package package }

python_virtualenv node.mollyproject.install_root do
  owner node.mollyproject.user
  group node.mollyproject.user
end