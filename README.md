# <u>C5 DEPLOYMENT WORKLOAD 2</u>

#### _Deployment of a WebApp into AWS Elastic BeanStalk - fully automated way (unlike to Workload 1)_

<u>## OBJECTIVE/<u>
In this assignment, entirely in AWS, a Retail Banking App is deployed - with all source files 
built in GitHub, tested by a Jenkins server in AWS and by AWS CLI deployed to AWS Beanstalk.


## <u>PROCESS</u>

1. An AWS t2.micro EC2 (_[steps found here](https://github.com/ClintKan/C5-Deployment-Workload-2/blob/main/EC2_creation_how-to.txt)_) was created the following security configurations

- Port configuration; 22 for SSH
- Port configuration; 8080 for Jenkins
- An AWS Secret key was created with a use case selection being "Command Line Interface (CLI)"

<div align="center">
	<img width="1345" alt="Pasted Graphic 6" src="https://github.com/user-attachments/assets/8a1cf22e-2037-4cf3-9c09-0621dc18f3c1">
</div>


- **_These keys are used to establish a secure connection between two systems._**
- **_These keys are never shared/displayed publicly, but rather input directly in the systems that need them._**


2. Jenkins was installed installed on the EC2 using the script named "_install_jenkins.sh_"


```sh
sudo apt update && sudo apt install fontconfig openjdk-17-jre software-properties-common && sudo add-apt-repository ppa:deadsnakes/ppa && sudo apt install python3.7 python3.7-venv
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

```


3. Jenkins GUI is logged into via **_http://[public-ip-address-of-ec2]:8080/_** using the initial admin password displayed by running the command;
```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

4. Create a pipeline in Jenkins ([_steps found here_](https://github.com/ClintKan/C5-Deployment-Workload-2/blob/main/JenkinsPipeline_creation_how_to.txt)).

Upon completion, an image similar to the one below should appear
<div align="center">
  <img width="1091" alt="Pasted Graphic 8" src="https://github.com/user-attachments/assets/47b8d4b2-7e27-432e-9a72-558787956b04">
</div>

5. Because a user named Jenkins is automatically createdduring process step #, change the password of it by running the command below;

```sh
sudo passwd jenkins
```

#### Verification of existent of Jenkins admin account and it's password change.

<div align="center">
  <img width="730" alt="Pasted Graphic 10" src="https://github.com/user-attachments/assets/ce636f59-b215-4f78-b90a-f1d4d5ebf74d">
</div>

**<ins>Note:</ins>**
To  navigate to the environment that holds the files executed by Jenkins, the navigaion woulld require to;
- Navigate the terminal as the user Jenkins, therefore switching to the user Jenkins if not already.
- Might require a password change if it's not known
```sh
sudo passwd jenkins # password change of the user jenkins
sudo su - jenkins # switching into the user jenkins
```
- Then, navigating into the directory
```sh
cd ./workspace/ELB_Pipeline_main && ls -al
```


6. AWS CLI was then installed on the same EC2, using the script named "_install_aws_cli.sh_"

```sh
sudo apt-get install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

```

#### Verification of proper AWS-CLI installation.

<div align="center">
  <img width="656" alt="Pasted Graphic 9" src="https://github.com/user-attachments/assets/4cb552f8-a0a8-4dfe-bdb7-d86db9f988e5">
</div>





