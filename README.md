# 🚀 Ad-Hoc Automation on Azure — 4 VMs, Custom Inventory & Passwordless SSH

## 📘 Project Overview  
This project demonstrates how to provision infrastructure using **Terraform**, configure **passwordless SSH**, define a **custom Ansible inventory**, and execute **Ansible ad-hoc automation** across a fleet of virtual machines—without writing a full playbook.

This approach is ideal for rapid DevOps validation, sandbox provisioning, or one-off fleet operations in development environments.

## 🎯 Objectives
✅ Provision **4 Ubuntu VMs** in Azure using Terraform  
✅ Configure **passwordless SSH access** using a private key  
✅ Create a **custom Ansible inventory** with host grouping  
✅ Run **ad-hoc Ansible commands** (ping, uptime, package install, service restart)  
✅ Demonstrate `--become` usage for privilege escalation  
✅ Showcase infrastructure automation from provisioning to orchestration  

## 🏗️ Architecture
| VM Index | Group | Purpose        |
|----------|--------|----------------|
| VM 0     | web    | Web layer      |
| VM 1     | web    | Web layer      |
| VM 2     | app    | Application    |
| VM 3     | db     | Database       |

## 📦 Tools & Technologies Used
| Tool        | Purpose                     |
|-------------|----------------------------|
| Terraform   | Provision Azure resources   |
| Azure CLI   | Authentication & Access     |
| OpenSSH     | Passwordless SSH            |
| Ansible     | Fleet automation (ad-hoc)   |
| Ubuntu LTS  | VM OS image                 |

## 📂 Project Structure

```
terraform-ansible/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── inventory.ini
├── yes (private SSH key - ignored in Git)
├── yes.pub (public SSH key)
├── README.md
└── .gitignore
```

## ✅ Step 1: Provision Azure VMs with Terraform

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 📍 Output: Public IPs
Terraform will display the list of IPs as output.

## ✅ Step 2: Set Up Passwordless SSH

Assuming you already generated keys:
```bash
ssh-keygen -t ed25519 -f yes -C "azure-vm-key"
```

Terraform automatically injects `yes.pub` into the VMs.

Test access:
```bash
ssh -i yes azureuser@<public_ip>
```

## ✅ Step 3: Create Ansible Inventory (`inventory.ini`)

```ini
[web]
<ip_of_vm0>
<ip_of_vm1>

[app]
<ip_of_vm2>

[db]
<ip_of_vm3>

[all:vars]
ansible_user=azureuser
ansible_ssh_private_key_file=./yes
```

## ✅ Step 4: Run Ad-Hoc Commands

### 🔹 Test Connectivity (Ansible Ping)
```bash
ansible all -i inventory.ini -m ping
```

### 🔹 Check uptime
```bash
ansible all -i inventory.ini -a "uptime"
```

### 🔹 Install NGINX (on web group only, with sudo)
```bash
ansible web -i inventory.ini -b -m apt -a "name=nginx state=present update_cache=yes"
```

### 🔹 Ensure nginx is running
```bash
ansible web -i inventory.ini -b -m service -a "name=nginx state=started enabled=yes"
```

### 🔹 Check disk usage (all hosts)
```bash
ansible all -i inventory.ini -a "df -h"
```

## 🧠 Reflection  
This project highlighted the power of **ad-hoc automation for rapid operational tasks**, especially when validating connectivity, installing quick patches, or performing checks across environments. While ad-hoc commands are ideal for exploratory or one-time actions, **playbooks are essential for repeatable, version-controlled automation pipelines** in production environments.

## 🙏 Acknowledgment  
Grateful to **Pravin Mishra** and the **DevOps Micro Internship (DMI) community** for enabling hands-on, real-world projects that transform theoretical learning into professional-grade DevOps workflows.

**— Olajide Salami**  
*DevOps Engineer | Cloud Automation Enthusiast*

## 📎 License
This project is for educational and professional demonstration purposes.