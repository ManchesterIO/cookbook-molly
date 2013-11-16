include_recipe "build-essential"
include_recipe "git"
include_recipe "python"

user node.mollyproject.user do
  home node.mollyproject.install_root
end

directory node.mollyproject.install_root do
  owner node.mollyproject.user
  group node.mollyproject.user
end

%w(libgeos-c1 libprotobuf-dev protobuf-compiler ruby1.9.3).each { | package | package package }
%w(compass zurb-foundation).each do | gem |
  gem_package gem do
    gem_binary "gem"
  end
end

python_virtualenv node.mollyproject.install_root do
  owner node.mollyproject.user
  group node.mollyproject.user
end