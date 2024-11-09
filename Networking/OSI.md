
When requesting www.medium.com

1. DNS resolution
2. TCP hand shake
3. ISO/OSI
  below one 
### Clienr End                                                               ### Receiver End

7. Application Layer                                                         1. Physical Layer
6. Presentation Layer                                                        2. DataLink Layer
5. Session Layer                                                             3. Network Layer
4. TransPort Layer                                                           4. TransPort Layer
3. Network Layer                                                             5. Session Layer
2. DataLink Layer                                                            6. Presentation Layer
1. Physical Layer                                                            7. Application Layer


765[Happensinthebrowser]

3[Router]
2[switches]
1[1's,0'seletricalsignals]



Here’s a breakdown of what happens when a client requests `www.medium.com`, from DNS resolution and the TCP handshake to the ISO/OSI model flow at both the client and server ends.

### 1. DNS Resolution
   - **Goal**: Convert `www.medium.com` (a domain name) into an IP address.
   - **Process**:
     - The client checks the local DNS cache. If the IP address is not cached, the request goes to a DNS resolver (often provided by the ISP).
     - The DNS resolver queries DNS servers in a hierarchy, starting from the root server, then to the `.com` TLD server, and finally the authoritative server for `medium.com`.
     - The authoritative DNS server returns the IP address for `www.medium.com`.
   - **Result**: The client now knows the IP address of the destination server.

### 2. TCP Handshake
   - **Goal**: Establish a reliable connection between the client and the server using the Transmission Control Protocol (TCP).
   - **Steps**:
     - **SYN**: The client sends a TCP packet with the SYN (synchronize) flag set, requesting a connection to the server.
     - **SYN-ACK**: The server responds with a packet that has both the SYN and ACK (acknowledge) flags set, confirming the connection.
     - **ACK**: The client replies with an ACK packet to finalize the handshake.
   - **Result**: The TCP connection is now established, allowing for reliable data transmission.

### 3. OSI Model Data Flow
This breakdown explains how each layer of the OSI model on the client side corresponds to the layers on the server side, detailing the process of sending and receiving the data.

#### Client Side (Sending Request)
   1. **Application Layer (Layer 7)**: 
      - The client’s browser generates an HTTP request for `www.medium.com`.
   2. **Presentation Layer (Layer 6)**: 
      - Formats the data for transmission, handling things like data encoding, encryption, or compression if required.
   3. **Session Layer (Layer 5)**: 
      - Manages the session for this connection, maintaining the state and managing communication between the client and the server.
   4. **Transport Layer (Layer 4)**: 
      - TCP divides the data into segments, adds port numbers, and ensures reliable data transfer with error checking.
   5. **Network Layer (Layer 3)**: 
      - Adds the IP addresses of both the client (source) and the server (destination) to the data packets.
   6. **Data Link Layer (Layer 2)**: 
      - Frames the packets, adding MAC addresses for the next hop in the data link layer (e.g., from client to router).
   7. **Physical Layer (Layer 1)**: 
      - Converts the data into signals (electrical, optical, or radio) and transmits them through the physical network medium (like Ethernet or Wi-Fi).

#### Server Side (Receiving Request)
   - As the data flows from the client to the server, it goes through the OSI layers in reverse order, starting at the **Physical Layer** and moving up to the **Application Layer**.

   1. **Physical Layer (Layer 1)**: 
      - Receives the physical signals (electrical or optical) and converts them into data.
   2. **Data Link Layer (Layer 2)**: 
      - Verifies and extracts frames, identifying the MAC address for the incoming request and passing it to the Network Layer.
   3. **Network Layer (Layer 3)**: 
      - Uses the IP address in the packet to direct the data to the correct service or application on the server.
   4. **Transport Layer (Layer 4)**: 
      - The server’s TCP stack reassembles the segments, confirms the data’s integrity, and acknowledges receipt to the client.
   5. **Session Layer (Layer 5)**: 
      - Manages the session state, allowing the server to continue communicating with the client.
   6. **Presentation Layer (Layer 6)**: 
      - Decodes, decrypts, or decompresses data if necessary, converting it into a readable format for the application.
   7. **Application Layer (Layer 7)**: 
      - The server’s application (in this case, Medium’s web server) processes the HTTP request and generates an HTTP response, which is sent back to the client through the same layers in reverse order.

### Summary of Data Flow in OSI Layers:
   - **Client End**: Starts from **Application Layer (Layer 7)** down to **Physical Layer (Layer 1)**.
   - **Server End**: Receives data from **Physical Layer (Layer 1)** up to **Application Layer (Layer 7)**. 

This sequence ensures data is packaged, transmitted, and interpreted accurately on both ends, enabling the client to view `www.medium.com`.





















In a network with multiple routers connected to a switch, each router manages network traffic for its own set of private devices and uses Network Address Translation (NAT) to map private IP addresses to a public IP address when communicating with the internet. Here’s how NAT and MAC addressing work in this scenario:

1. **Network Address Translation (NAT)**:
   - Each router has its own public IP address assigned by the Internet Service Provider (ISP). This public IP allows it to communicate with devices outside the local network (such as over the internet).
   - Inside each router's network, devices use private IP addresses (e.g., `192.168.x.x` or `10.x.x.x`), which are not routable on the internet.
   - When a device (say, a computer) inside a router’s network needs to communicate with an external server (e.g., a website), the router performs NAT:
     - **Source NAT (SNAT)**: The router translates the private IP of the device into its public IP address before sending the request to the internet.
     - **Port Translation**: To track multiple devices using the same public IP, the router assigns a unique port number to each outgoing connection. This combination of the router’s public IP and port number helps direct incoming responses to the correct device.

2. **MAC Addresses and Frame-Level Addressing**:
   - In a local network, devices use MAC (Media Access Control) addresses for communication within the same local network (Layer 2). A MAC address is a unique identifier assigned to each network interface card (NIC) in a device.
   - When a device wants to communicate within its local network, the data is encapsulated into frames that include the destination MAC address. This helps switches forward data at the data link layer without needing IP information.

3. **How Routers Handle MAC Addresses**:
   - **Within the Local Network**: When a device sends data to a router, the data frame includes the router’s MAC address as the destination MAC. The router's IP address will be used as the destination IP in the packet header. Inside the router’s network, MAC addresses are essential for identifying devices on the same local link.
   - **After NAT**: When a packet is sent from the router to an external network (like the internet), the router strips the internal MAC address of the original device. The packet that goes out will have the router’s public IP as the source IP, and the router’s external MAC (connected to the ISP) as the source MAC.

4. **Response Traffic**:
   - When a response comes back from the internet, it’s directed to the router’s public IP.
   - The router uses its NAT table to translate the destination public IP and port back to the original private IP and port of the requesting device.
   - The router then forwards the data back to the device, now with the device’s MAC address as the destination MAC, so the switch can deliver it to the correct device.

In short, NAT happens at the IP layer, allowing routers to map private IP addresses to their public IP, while MAC addresses are used within the local network to ensure data reaches the right device on the switch. This process allows multiple private devices to communicate externally using a single public IP address.