### **DNS (Domain Name System)**
DNS is like the phone book of the internet. It translates human-readable domain names (like `www.example.com`) into IP addresses (like `192.0.2.1`) that computers use to locate each other on the network.

- **Key Points about DNS**:
  - **Purpose**: To resolve (translate) domain names into IP addresses.
  - **How It Works**: When you type a web address in your browser, your computer contacts a DNS server, which looks up the IP address associated with the domain name and returns it.
  - **Example**: You enter `www.google.com`, DNS resolves it to an IP address like `142.250.64.78`.
  - **DNS Servers**: Can be run by your ISP (Internet Service Provider), Google (`8.8.8.8`), Cloudflare (`1.1.1.1`), or others.

### **DHCP (Dynamic Host Configuration Protocol)**
DHCP automatically assigns IP addresses to devices on a network. This ensures that devices can join a network without manual configuration.

- **Key Points about DHCP**:
  - **Purpose**: To assign IP addresses and other network configuration parameters (like DNS servers and gateways) to devices.
  - **How It Works**: When a device connects to a network, it sends a broadcast request asking for an IP address. A DHCP server on the network assigns it an IP address, along with other details like subnet mask, DNS servers, and default gateway.
  - **Dynamic vs. Static**: DHCP is dynamic, meaning devices get temporary IP addresses that can change. Static IP addresses are manually set and don’t change.
  - **Example**: You connect your phone to a Wi-Fi network, and it automatically gets an IP address like `192.168.1.10`.

In short:
- **DNS** helps find addresses for websites.
- **DHCP** gives devices IP addresses automatically when they connect to a network.