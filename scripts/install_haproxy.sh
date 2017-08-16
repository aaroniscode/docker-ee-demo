# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')

# Install HAProxy
echo "Installing HAProxy"
sudo apt-get install -y haproxy

# Comment out the httplog option
echo "Updating HAProxy config part 1"
sudo sed -i 's/option\thttplog/# option httplog/' /etc/haproxy/haproxy.cfg

# Set the default mode to tcp
echo "Updating HAProxy config part 2"
sudo sed -i 's/mode\thttp/mode\ttcp/' /etc/haproxy/haproxy.cfg

# Set the tunnel timeout to 1 hr
# Allows long running connections to containers
# Was required for install of DTR 2.3.0 or a timeout occured
echo "Updating HAProxy config part 3"
sudo sed -i '/mode\ttcp/a\\ttimeout tunnel 1h' /etc/haproxy/haproxy.cfg

# Configure the frontend and backends
echo "Updating HAProxy config part 4"
sudo cat << EOF >> /etc/haproxy/haproxy.cfg

frontend global
	bind *:443
	mode tcp
	tcp-request inspect-delay 5s
  tcp-request content accept if { req_ssl_hello_type 1 }

	use_backend ucp if { req_ssl_sni -i ucp.${tld} }
	use_backend dtr if { req_ssl_sni -i dtr.${tld} }
	default_backend workers

backend ucp
	mode tcp
	server manager1 127.0.0.1:8443

backend dtr
	mode tcp
	server manager1 127.0.0.1:9443

# TODO, not complete
backend workers
  mode tcp
	server worker1 127.0.0.1
EOF

# Restart HAProxy to use the new configuration
echo "Restarting HAProxy"
sudo systemctl restart haproxy
