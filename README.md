# AD-Labs overview
This is a collection of active directory labs conducted in a virtual environment hosted in a hyperconverged Proxmox VE cluster. 

---
# Lab Compontents
- Proxmox VE 7.4 Host
  - OVS Bridge 500
  - OVS IntPort 500
- Server Windows Server 2022
- Client Windows Enterprise 11

# Lab Topology
![Lab Diagram](diagrams/AD-LAB-Topology.png)

 Proxmox VE is used to host both client and server under an OVS bridge and OVS intport

The Domain controller acts as ADDS, DNS, DHCP, RAS server.  

```
Start-Process powershell -Verb RunAs -ArgumentList "Install-WindowsFeature -Name AD-Domain-Services, DNS, RemoteAccess, DHCP -IncludeManagementTools -Restart"
```
The script above will install the required server components on the Domain Controller (DC)



 




