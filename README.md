<p align="center">
  <img src="https://cloud-assets.webvirt.cloud/images/github-preview.png">
</p>

# WebVirtCloud #

WebVirtCloud is a web-based virtualization platform that allows users to manage and create virtual machines on a remote server. You just need to install WebVirtCloud on a server or even your laptop or PC and you can use it to create, manage, and delete virtual machines. It is a self-hosted alternative to platforms like DigitalOcean, Linode, and Vultr.

## Development RoadMap for VPS hosting
List of features that is reqired for VPS hosting.

- VPS network traffic metering
    - Monthly traffic can be view by admin and user.
    - Automatically disable network or speed limiting when monthly traffic reaches specific limitation.
    - Metering in in/out/both network traffic direction.
    - Metering in public/private network zone (IP).
- A Switch to enable/disable billing feature for a user/globally.
    - API improvement for WHMCS, Blesta or others
    - Only Admin panel or admin API can create or delete VM
- VPS IP Management
    - Add IP Range/single IP Address for a zone or single compute node.
    - Bind MAC address to single IP Address (e.g. OVH additional IP)
    - Reserve specific IP Address
    - Frontend/backend can modify VM allocated IP Address
    - Options to only enable public/private/compute IP
- VPS Management
    - Add List view in VM list
    - Add display filter in VM list
        - can be filtered by user info, zone, compute node, IP .etc
    - More VM configuration field.
        - e.g. VirtIO settings
        - directly modify VM definition xml.
    - Change VM owner user
    - VM cold migration between compute node (even across zone)
- VM Size/Plan management
    - More options (e.g. virtio options)
    - Snapshot/backup Quota
- OS Template improvement
    - Add download link option to existing and new templates
        - Auto update MD5 checksum
    - Clean up templates images that is not frequently used.
    - Custom OS type e.g. Alpine OpenSUSE
- Backend logic improvement
    - Add logic to validate VM configuration at time of VM creation
        - avoid creating invalid VM instance
- More...


## Features ##

* **User management**: WebVirtCloud allows you to create and manage users.
* **Virtual machine management**: You can create, manage, and delete virtual machines on a remote server.
* **Virtual machine templates**: Pre-configured virtual machine templates, such as Ubuntu, Debian, Fedora, CentOS, Almalinux and Rocky Linux.
* **Firewall management**: You can manage the firewall rules for your virtual machines.
* **Floating IP management**: You can manage floating IPs for your virtual machines.

## How it works ##

We have two components: the **controller** and the **compute**. The controller is the web interface that allows you to manage your virtual machines. The [compute](https://github.com/webvirtcloud/webvirtcompute) is the hypervisor that runs the virtual machines.

## Recommended setup ##

We recommend running the controller and the compute on separate servers. The controller can be installed on a server or even your laptop or PC. The compute should be installed on a server with virtualization support (e.g. KVM).

## Multi region support ##

WebVirtCloud supports multi-region. You can have multiple compute nodes in different regions and manage them from the same controller. 

## Requirements ##

* [Docker](https://www.docker.com/get-started/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Controller configuration ##

To install WebVirtCloud, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/webvirtcloud/webvirtcloud.git
```

2. Change into the webvirtcloud directory:

```bash
cd webvirtcloud
```

3. Run script for deploy WebVirtCloud:

```bash
./webvirtcloud.sh env
```

4. Start WebVirtCloud:

```bash
./webvirtcloud.sh start
```

6. Open client side in browser (example for domain: `webvirtcloud.app`):

```url
http://client.webvirtcloud.app
```

7. Open admin side in browser (example for domain: `webvirtcloud.app`):

```url
http://manage.webvirtcloud.app
```

**Warning**: If you use `webvirtcloud.app` or your own wildcard domain you need to allow SSL certificate in browser.

For assets:

```url
https://assets.webvirtcloud.app
```

and for API:

```url
https://api.webvirtcloud.app
```

## Credentials ##

Default credentials for admin side:

```bash
username: admin@webvirt.cloud
password: admin
```

You can create new user in admin side or register new user in client side.

## Update controller ##

Run script for update:

```bash
./webvirtcloud.sh update
```

** Warning: ** Don't forget update [WebVirtCompute](https://github.com/webvirtcloud/webvirtcompute?tab=readme-ov-file#update-webvirtcompute-daemon) daemon on nodes after update controller.

## Additional settings ##

You can change the default settings in the `custom.env` file. Just copy variables you want to change from the `global.env` file and change them in the `custom.env` file. Example for mail settings:

```bash
# Email environment variables
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER = admin
EMAIL_HOST_PASSWORD = admin
EMAIL_USE_TLS = True
EMAIL_FROM = "WebVirtCloud <noreply@gmail.com>"
```

## Compute configuration (hypervisor) ##

More information about the compute configuration can be found in the [WebVirtCompute](https://github.com/webvirtcloud/webvirtcompute) repository.

## Private networking ##

If you don't have additional network interfaces on your server for private network, you can use the [WireGuard](https://www.wireguard.com) VPN to create a private network between the controller and the compute.

## License ##

WebVirtCloud is licensed under the Apache 2.0 License. See the `LICENSE` file for more information.
