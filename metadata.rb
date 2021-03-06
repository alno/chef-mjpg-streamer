name             "mjpg-streamer"
maintainer       "Alexey Noskov"
maintainer_email "alexey.noskov@gmail.com"
license          "MIT"
description      "Installs Mjpg streamer."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"
source_url      'https://github.com/alno/chef-mjpg-streamer' if respond_to?(:source_url)
issues_url      'https://github.com/alno/chef-mjpg-streamer/issues' if respond_to?(:issues_url)

recipe "mjpg-streamer", "Set up the mjpg-streamer server"

supports "ubuntu"

depends "runit"
