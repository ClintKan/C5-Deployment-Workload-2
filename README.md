# <ins>C5 DEPLOYMENT WORKLOAD 2</ins>

   #### _Deployment of a WebApp into AWS Elastic BeanStalk - fully automated way (unlike to Workload 1)_

## <ins> OBJECTIVE</ins>
In this assignment, entirely in AWS, a Retail Banking App is deployed - with all source files 
built in GitHub, tested by a Jenkins server in AWS and by AWS CLI deployed to AWS Beanstalk.

While in Workload #1, we had to manually upload a zipped file - as downloaded from GitHub repo, in this assignment we use the AWS' EC2 the command line interface of AWS to launch the app. This brings about more effeciency and automation capabilities, reduction in human errors. With that said, this might also make it a bid harder to troubleshoot in case of a error.

## <ins> SYSTEM DIAGRAM</ins>
<div align="center">
	<img width="752" alt="image" src="https://github.com/user-attachments/assets/83d2e7b9-bda6-41ed-9315-ae42a6302e64">
</div>


## <ins>PROCESS</ins>

1. An AWS t2.micro EC2 (_[steps found here](https://github.com/ClintKan/C5-Deployment-Workload-2/blob/main/ec2_creation_howto.txt)_) was created the following security configurations

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

5. A user named Jenkins is automatically created during process step #7 of the Jenkinsfile (located in C5-Deployment-Workload-2/Jenkinsfile) during the Jenkins pipeline run - at the build stage. This is key
   because not on is it the one that will have access to the files needed in the pipeline, but it is same user that is to be used to execute the commands.
   
6. The change the password of it by running the command below;

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
- Then, navigate into the directory
```sh
cd ./workspace/ELB_Pipeline_main && ls -al
```

7. AWS CLI was then installed on the same EC2, using the script named "_install_aws_cli.sh_"

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

**_But also the command "aws ec2 describe-instances" can be run to show all details about the AWS CLI_**

**<ins>Note:</ins>**

**_If the code "aws ec2 describe-instances" is run, it may hang mid-way and not proceed - this is a command that just displays so to quit it and proceed just press "Q" on your keyboard._**

8. Configuring AWS CLI & AWS Elastic Beanstalk in the terminal.

#### Pre-requisites:
- Prior to running the commands below, make sure you already have (if not create) an AWS CLI key pair - ([_see how here_](https://github.com/ClintKan/C5-Deployment-Workload-2/blob/main/AWSCLIKey_Creation_how_to.txt)).
The key pair; a AWS Access Key ID  & Secret Access Keys, will have to be input into the terminal to initiate a secure connection between the terminal CLI - Command Line Interface and Jenkins environment.
- You will need to know the scripting language to use, the region name and the output format decided on - in this assignment's case I used 'python3.7', '_us-east-1_' and '_json_' respectively.
- Working in a virtual environment and using another user named "Jenkins"


=> Run the commands below;
```sh
python3.7 -m venv venv # to create a virtual environment called venv (optional since Jenkins already created it in the Built phase)

source venv/bin/activate # to get into a virtual environment called "venv"

pip install awsebcli && eb --version #to install aws elastic beanstalk CLI in the terminal

aws configure #activating the aws CLI that was installed in earlier steps - it is at this step where you specify the region and output format of the app.

eb init #an initiation of the elastic beanstalk
```

9. Head to Jenkins Web GUI to then run pipeline - Build, Test and Deploy

<div align="center">
	<img width="1132" alt="Screenshot 2024-08-14 at 3 22 18 PM" src="https://github.com/user-attachments/assets/b8c0aac8-baaf-4fa8-ac2a-d3463b33c5a1">
</div>

**<ins>Note:</ins>** If an error is encountered during the Jenkins pipeline build and testing, it could be due to the following;

	(i)   Traverse the error logs in Jenkins and/or AWS and then act accordingly.
 	(ii)  A missing deployment stage, or improper denting or closing of a stage in the Jenkins configuration file.
	(iii) Naming the Elastic Beanstalk a name that contains invalid characters - name must contain only letters, digits, and the dash character and may not start or end with a dash. Fixable by updating the Jenkins file
 	      in the Deploy stage part of the code.
 	      
   
10. If all is successful, you should navigate to ([_AWS Elastic Beanstalk_](https://us-east-1.console.aws.amazon.com/elasticbeanstalk/home)] menu to see if there exists a created environment and application.
   In my case, regarding this project, with the WebAp accessible.


<div align="center">
	<img width="1198" alt="image" src="https://github.com/user-attachments/assets/4d8d37bf-e171-4601-94e0-9b941b5a2624">
</div>


<div align="center">
   	<img width="1112" alt="image" src="https://github.com/user-attachments/assets/5dd2ec0a-6661-4b7f-8c01-670002ea90c1"> 
</div>
   
