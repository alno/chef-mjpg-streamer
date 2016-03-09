package "subversion"
package "graphicsmagick"
package "graphicsmagick-imagemagick-compat"

case node['platform']
  when "redhat", "centos", "scientific", "fedora", "suse", "amazon"
    package %w(libv4l-devel libjpeg-devel)
  when "debian", "ubuntu"
    package %w(libv4l-dev libjpeg-dev)
end

url = node['mjpg_streamer']['checkout_url']
dir = node['mjpg_streamer']['checkout_dir']

execute "installing mjpg_streamer" do
  command "rm -rf #{dir} && svn checkout \"#{url}\" #{dir} && cd #{dir} && make install && cd && rm -rf #{dir}"
  not_if { File.exists? "/usr/local/bin/mjpg_streamer" }
end
