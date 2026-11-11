# Entra Zero Trust Baseline

**A complete, secure identity setup for a fictional 80-person company, built in Microsoft Entra ID the way a Microsoft partner would deliver it to a real customer.**

## The scenario

Kessler Elektronik GmbH (fictional) has 80 employees, three departments and external partners. They need to make sure the right people get access to the right things, and nobody else does.

## What this project delivers

- **Secure sign-in:** passwordless login and multi-factor authentication
- **Smart access rules:** access depends on who you are, your device and the risk of the sign-in
- **Protected admin accounts:** admins get elevated rights only when needed and only for a limited time
- **Partner access:** external partners get controlled access that expires automatically
- **Automated access reviews:** unneeded access is found and removed regularly
- **Monitoring:** alerts on suspicious sign-ins and emergency account use

## How it's built

Everything is configured **as code** (Terraform) rather than by clicking through a portal. That means the setup is repeatable, reviewable and documented.

## Progress

| Area | Status |
|---|---|
| Users, groups and delegated admin rights | ✅ Done |
| Sign-in security and access rules | ⏳ In progress |
| Partner access and governance | ⏳ Planned |
| Admin protection and monitoring | ⏳ Planned |

## Skills demonstrated

Microsoft Entra ID · Zero Trust · Conditional Access · Privileged Identity Management · Identity Governance · Terraform · Microsoft Graph PowerShell · SC-300 aligned

---

*All people and companies in this project are fictional.*