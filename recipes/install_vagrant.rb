bash 'Setup Molly' do
  cwd '/tmp'
  user node.mollyproject.user
  group node.mollyproject.user
  code "#{node.mollyproject.install_root}/bin/python /molly/setup.py develop"
end