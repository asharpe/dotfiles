# If nothing is set, we'll use the default value, though you can avoid that by
# explicitly setting the proxy to nothing, ala
# $ proxy= vagrant up ...
proxy = ['VAGRANT_PROXY', 'proxy', 'http_proxy'].reduce(false) { |acc, n| acc ||= ENV[n] } || 'http://10.0.2.2:3142'
# we'll also put it into our own environment in a known place
ENV['proxy'] = proxy if proxy

if proxy
	puts "Using proxy at #{proxy}"
end

# see https://groups.google.com/d/msg/vagrant-up/wa8mNt34TWk/HdoQN5zYN6cJ
if defined? VagrantVbguest
	# see https://github.com/dotless-de/vagrant-vbguest#advanced-usage
	class MyRedHatInstaller < VagrantVbguest::Installers::RedHat
		def install_dependencies_cmd
			# if we find a proxy or http_proxy environment variable, we'll use that
			# for installation of dependencies via yum
			proxy = ENV['proxy'] ? "http_proxy=#{ENV['proxy'].sub(/^.*=/,'')} " : ''
			proxy + super
		end
	end

	# we can skip the proxy for this bit of the install by commenting out this line
	VagrantVbguest::Installer.register(MyRedHatInstaller, 6)
end

