data_dir = "var/persist/consul"
client_addr = "127.0.0.1 {{ GetPrivateInterfaces | join \"address\" \" \" }}"
