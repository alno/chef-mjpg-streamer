package "subversion"
package "graphicsmagick"
package "graphicsmagick-imagemagick-compat"

case node['platform']
  when "redhat", "centos", "scientific", "fedora", "suse", "amazon"
    package %w(libv4l-devel libjpeg-devel)
  when "debian", "ubuntu"
    package %w(libv4l-dev libjpeg-dev)
end

# Install it from source
unless ::File.exists? "/usr/local/bin/mjpg_streamer"
  build_dir = node['mjpg_streamer']['build_dir']
  patch_dir = node['mjpg_streamer']['patch_dir']

  directory patch_dir

  cookbook_file "#{patch_dir}/extend_device_name.patch" do
    source 'extend_device_name.patch'
  end

  execute "installing mjpg_streamer" do
    command <<-CMD
      rm -rf "#{build_dir}" && \
      svn checkout "#{node['mjpg_streamer']['checkout_url']}" "#{build_dir}" && \
      cd "#{build_dir}" && \
      patch -p0 -i "#{patch_dir}/extend_device_name.patch" && \
      make install && \
      cd .. && \
      rm -rf "#{build_dir}" "#{patch_dir}"
    CMD
  end
end
