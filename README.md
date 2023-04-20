# AD-Labs overview
This is an active directory lab conducted in a virtual environment hosted in a hyperconverged Proxmox VE cluster. 

The scripts in this repo will help generate an Active Directory lab with users that decided to make poor password choices. 

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

Run the script below to install required lab services

```
Start-Process powershell -Verb RunAs -ArgumentList "Install-WindowsFeature -Name AD-Domain-Services, DNS, RemoteAccess, DHCP -IncludeManagementTools -Restart"
```

To Do:
  - Review and improve deployment scripts
    - DHCP configuration via powershell
    - RAS configuration via powershell
  - GUI
  - Output file for "lab key"



## Credits

Many, Many hours have been poured into this repo. It has been a learning experience and I want to thank the folks that unkownly assisted and inspired me to challenge myself. 

https://github.com/johnhammond
https://github.com/joshmadakor1