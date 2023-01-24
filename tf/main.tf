provider "proxmox" {
    pm_api_url = var.proxmox_host["pm_api_url"]
    pm_user = var.proxmox_host["pm_user"]
    pm_password = var.proxmox_host["pm_pass"]
    pm_tls_insecure = true
}

resource "proxmox_lxc" "lxc-test" { 
    count = length(var.hostnames)
    hostname = var.hostnames[count.index]
    cores = 1
    memory = "1024"
    swap = "2048"
    ostemplate = "local:vztmpl/ubuntu-22.10-standard_22.10-1_amd64.tar.zst" 
    password = "123456"
    target_node = "breda"
    unprivileged = true
    start = true
    vmid = var.vmid + count.index

    ssh_public_keys = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCStIRocn3UOL15XHjo3bq7ECNg1YBcJMt956oHG5ShORrvZzvDChCtH1UDO4YD4dDEUCxoKvsrYzOyLTrLjN+mukq/jDUceNOoIRDfcqSkZKWpYWmt6QB0tcwpgWACzcJzc0H7HZyr5vxoN18yekHFf1vlBLLd2iGM6PFDvqlCPMC4g2sPmqYI3pyC/2M+21T/g+61kYTZiGJIkYZfG+Ql8uFYxRflp2W9/7VnS4H2o07N4We2NV98zSFxXjsJtLEn51uz0aJAer1Qjkv99mu6K/n64fmxT7xprZ9mNWBQCgFKB7a1v6x//sgi6ZH6hBPmqXGJ8md3HahF7+mYeQJJGjltuCDtVQiNZUwK+tLZ4Pno77TEf9A4A5ChRc0bgRngMwSJ0/ZbHtgxYtdKJTPvA28rOookMnk6+S5WBZv4C/a5ECp7KWiA0GD1iSRK9eTv3ogmgoUnZ6Gc52EaFYIP7SVEOGL5vB/5/H14Qsa4kDQ8UkPVpENdwk9K+AMX6v0= marcelo@fedora
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpnCB+vUbUsMgGzCoEPQ+K5MC0inStbhhDP78Yt/6dHhQoAle7LlO66+5TPhvnsp+S/XFIkal5gl2Ohgd1TohqA6MMrU876TEQSjrPAYgl2ZpI/OunUuApKOCLvJFIshPax1fOJsPogIYbfYc2L1QVCqvgTXYkElVM18Hic0v6gQY9Zv+kuM0yDGu73Y6kbwD+3qJuR+BPsLZ1KExEyROcEquMCIfJsxAJFoUisEMmo0vE7xOMj07C/89ovBXy2E5DZiREwJxxCJeXaYdlXljPxKf8hnnYoV6qAj4aAqm+GYSOTvbtnU2kVp+H2jTuFNtPmHi6jjLW8pWWonLtItmFlnL4koaxdiMv5lJIr+pWddDQ3Hgq9vGOhuJtUK+0GDOGVc4JxzeJX+GzfBzwM8N/ozA5VDLCcObTH/8DLbGOLV4C2zUdan16udMicgNul6M9I2m9bCM30317IvGQgiUYcfYcB6Kqb9/LW3j7ZGsRex3G+nCOg1a796emnyy2A8M= jenkins@jenkins
  EOT

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "${var.ips[count.index]}/24,gw=${cidrhost(format("%s/24", var.ips[count.index]), 1)}"  
    }

    rootfs {
    storage = "local-lvm"
    size    = "8G"
  }
    
}