
# ☁️ Cloud Cleaner Bot

A lightweight shell script that automates the cleanup of AWS resources such as stopped EC2 instances, unattached EBS volumes, EBS snapshots, and unassociated Elastic IPs — helping reduce costs and maintain a clean cloud environment.


## 🚀 Features

- Deletes **unattached EBS volumes** to free up space.
- Releases **unused Elastic IPs** to avoid unnecessary charges.
- Identifies **stopped EC2 instances** to help optimize resource usage.
- Cleans up **EBS snapshots** to reduce storage costs.
- Automates cleanup operations via a **bash script** using the AWS CLI.



## 💻 Tech Stack

- Bash/Shell Scripting
- AWS CLI

## 🌐 AWS Services Used

- EC2, IAM, Elastic IP, EBS (Volumes and Snapshots)


## 🛠️ Installation

1. Make sure you have **AWS CLI** installed and configured:
   ```bash
   aws configure

2. Clone the Repository:
   ```bash
    git clone https://github.com/Nishika10/Cloud_Cleaner_Bot.git
    cd Cloud_Cleaner_Bot

3. Give execution permission to the script:
   ```bash
   chmod +x Cloud_Cleaner_Bot.sh

    
## 📦 Usage

1. Run the script using the command:
   ```bash
   ./Cloud_Cleaner_Bot.sh
   
The script will:

- List and delete unattached EBS volumes.
- Release any unused Elastic IPs.
- Show stopped EC2 instances and ask if you want to delete them.
- List available EBS snapshots and ask if you want to delete them.

⚠️ Make sure your IAM user has sufficient permissions to perform these actions.
## 📚 Lessons Learned
- Learned how to interact with AWS resources using AWS CLI.

- Gained hands-on experience in writing automated bash scripts.

- Understood cost optimization practices in real AWS environments.

- Explored how to make scripts safer with user prompts and validations.


## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



## 👩‍💻 Author
Nishika Jaiswal  
Aspiring Cloud & DevOps Engineer
