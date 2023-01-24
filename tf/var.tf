variable "proxmox_host" {
	type = map
     default = {
       pm_api_url = "https://192.168.0.200:8006/api2/json"
       pm_user = "root@pam"
       pm_pass = "123456"
       target_node = "breda"
     }
}

variable "vmid" {
	default     = 400
	description = "Starting ID for the CTs"
}


variable "hostnames" {
  description = "VMs to be created"
  type        = list(string)
  #default     = ["prod-vm", "staging-vm", "dev-vm"]
  default     = ["docker-vm","docker-vm2"]
}

variable "rootfs_size" {
	default = "2G"
}

variable "ips" {
    description = "IPs of the VMs, respective to the hostname order"
    type        = list(string)
	#default     = ["10.0.42.80", "10.0.42.81", "10.0.42.82"]
  default     = ["192.168.0.161","192.168.0.162"]
}