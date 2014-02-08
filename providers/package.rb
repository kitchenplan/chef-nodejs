action :install do
  execute "install NPM package #{new_resource.name}" do
    command "npm -g install #{new_resource.name}"
    not_if "npm -g ls | grep '#{new_resource.name}'"
  end
  new_resource.updated_by_last_action(true)
end

action :install_local do
  path = new_resource.path if new_resource.path
  pkg_id = new_resource.name
  pkg_id += "@#{new_resource.version}" if new_resource.version
  execute "install NPM package #{new_resource.name} into #{path}" do
    cwd path
    command "npm install #{pkg_id}"
    not_if "cd #{path} && npm ls | grep '#{pkg_id}'"
  end
  new_resource.updated_by_last_action(true)
end

action :install_from_json do
  path = new_resource.path
  cmd  = "npm install"
  execute "install NPM packages from package.json at #{path}" do
    cwd path
    command cmd
  end
  new_resource.updated_by_last_action(true)
end

action :uninstall do
  execute "uninstall NPM package #{new_resource.name}" do
    command "npm -g uninstall #{new_resource.name}"
    only_if "npm -g ls | grep '#{new_resource.name}'"
  end
  new_resource.updated_by_last_action(true)
end

action :uninstall_local do
  path = new_resource.path if new_resource.path
  pkg_id = new_resource.name
  pkg_id += "@#{new_resource.version}" if new_resource.version
  execute "uninstall NPM package #{new_resource.name} from #{path}" do
    cwd path
    command "npm uninstall #{pkg_id}"
    only_if "cd #{path} && npm | grep '#{pkg_id}'"
  end
  new_resource.updated_by_last_action(true)
end
