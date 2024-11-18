# DNS[DomainNameSystem]
DNS (Domain Name System) is a critical component of the internet that acts as a translator between human-readable domain names (e.g., **www.example.com**) and machine-readable IP addresses (e.g., **192.0.2.1**). It ensures users can access websites or online resources without memorizing complex numerical addresses.

### How DNS Works:
1. **User Request**: When a user types a domain name in their browser or accesses a service, a DNS query is initiated.
2. **Recursive Resolver**: The query is sent to a **DNS resolver**, usually provided by the user's Internet Service Provider (ISP), to find the IP address associated with the domain.
3. **Root Server**: If the resolver doesn't know the IP address, it contacts a **root server** to locate the correct **Top-Level Domain (TLD) server** (e.g., `.com`, `.org`).
4. **TLD Server**: The TLD server directs the query to the appropriate **authoritative name server** for the domain.
5. **Authoritative Name Server**: This server provides the IP address for the requested domain.
6. **Response**: The resolver returns the IP address to the user's device, which then uses it to connect to the target server.

### Key DNS Components:
- **DNS Record Types**:
  - **A**: Maps a domain to an IPv4 address.
  - **AAAA**: Maps a domain to an IPv6 address.
  - **CNAME**: Maps a domain to another domain (aliasing).
  - **MX**: Specifies mail servers for a domain.
  - **TXT**: Contains arbitrary text for verification or configuration (e.g., SPF, DKIM).
  - **NS**: Points to the authoritative name servers for a domain.
  - **PTR**: Used for reverse DNS lookups (IP to domain).
  
- **Zones and Zone Files**: Domains are divided into zones, which contain configuration details like records stored in **zone files**.

### Why DNS is Important:
1. **User-Friendly**: Simplifies navigation on the internet.
2. **Redundancy and Availability**: Ensures reliability with multiple levels of resolution.
3. **Load Balancing and Scalability**: Distributes traffic across servers using features like DNS-based load balancing.
4. **Security**: Modern DNS includes protections like DNSSEC to prevent attacks such as DNS spoofing.

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

LinuxMachine[LocalCache] If not find www.google.com
     Then it will contacts Resolver[ProvidedbyISP] If not find
          Then it contacts root server it will maintains TLD like .com,.org,.in
              The TLD server query to appopriate authoritative name server for the domain
                  Name server gives the IP address
                      The Resolver returns IP address
                           The IP address was cached in ISP provider
                                The IP address was cached in local server also
                                    Next time it uses local cache


                                    When you request **app.google.com**, the DNS system resolves the domain name in a hierarchical manner. To understand how it's structured, let’s break it down into **TLS**, **SLD**, and other components.

### Example Breakdown: 
For **app.google.com**:
- **Root**: `.` (implied and invisible)
- **TLD**: `.com`
- **SLD**: `google`
- **Subdomain**: `app`


### **Step-by-Step Process**:
1. **Linux Machine (Local Cache)**:
   - The local machine checks its **DNS cache** for the IP address of **app.google.com**.
   - If found and valid (not expired), the system uses it to connect directly, skipping further steps.
   - **If not found**, it moves to the next step.

2. **Contact Resolver (Provided by ISP)**:
   - The query is sent to the **DNS resolver** (often managed by the ISP or a public DNS like Google `8.8.8.8`).
   - The resolver checks **its own cache** for the IP address.
   - If the IP is cached and valid, the resolver returns the IP to the local machine.
   - **If not found**, the resolver initiates a DNS query.

3. **Contact Root Server**:
   - The resolver queries a **root DNS server**, asking for the IP address of **app.google.com**.
   - The root server does not store domain IPs but knows where to find TLD information.
   - The root server directs the resolver to the **`.com` TLD server**.

4. **TLD Server (Top-Level Domain Server)**:
   - The `.com` TLD server knows which **authoritative name server** is responsible for the **google.com** domain.
   - It provides the resolver with the address of the **authoritative name server** for **google.com**.

5. **Authoritative Name Server**:
   - The authoritative name server for **google.com** is queried for the **app.google.com** subdomain.
   - The server responds with the **IP address** of **app.google.com**.

6. **Resolver Returns the IP**:
   - The resolver returns the IP address to the local machine.
   - Before returning, it **caches the IP address** (along with TTL) for future queries, making it available to other users or systems querying the same domain.

7. **Local Machine Caches the IP**:
   - The local machine receives the IP address and **caches it locally** for subsequent queries.
   - Now, the machine can use the IP to establish a connection to **app.google.com**.

8. **Next Time, Use Local Cache**:
   - If the user requests **app.google.com** again within the TTL, the local cache is used directly, skipping all the above steps.

---

### **Example Breakdown**:
For **app.google.com**:
- **Root**: Resolver contacts the **root server**, which directs to the TLD server for `.com`.
- **TLD**: The `.com` server provides the location of Google's authoritative name server.
- **SLD (Second-Level Domain)**: The **google.com** authoritative name server handles queries for all subdomains under it.
- **Subdomain**: The query for **app.google.com** is resolved by the authoritative server, which returns the IP for the **app** subdomain.

---

### **Caching Process**:
- **ISP Resolver Cache**:
  - Reduces query time for subsequent users of the same resolver.
- **Local Machine Cache**:
  - Allows the same machine to avoid network queries for repeated requests.
