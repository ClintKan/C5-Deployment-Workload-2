# C5 DEPLOYMENT WORKLOAD 2

#### _Deployment of a WebApp into AWS Elastic BeanStalk - fully automated way (unlike to Workload 1)_

## OBJECTIVE
In this assignment, entirely in AWS, a Retail Banking App is deployed - with all source files 
built in GitHub, tested by a Jenkins server in AWS and by AWS CLI deployed to AWS Beanstalk.

6432485

## PROCESS

1. An AWS t2.micro EC2 was created the following security configurations

- Port configuration; 22 for SSH
- Port configuration; 8080 for Jenkins
- An AWS Secret key was created with a use case selection being "Command Line Interface (CLI)"

<img width="1345" alt="Pasted Graphic 6" src="https://github.com/user-attachments/assets/8a1cf22e-2037-4cf3-9c09-0621dc18f3c1">

#### _These keys are used to establish a secure connection between two systems._
#### _These keys are never shared/displayed publicly, but rather input directly in the systems that need them_

2. Jenkins was installed installed on the EC2 using the script named "_install_jenkins.sh_"

```sh

```

#### Verification of Jenkins and admin account setup.



<img width="730" alt="Pasted Graphic 10" src="https://github.com/user-attachments/assets/ce636f59-b215-4f78-b90a-f1d4d5ebf74d">



3. AWS CLI was then installed on the same EC2, using the script named "_install_aws_cli.sh_"

```sh

```


#### Verification of proper AWS-CLI installation.

<img width="656" alt="Pasted Graphic 9" src="https://github.com/user-attachments/assets/4cb552f8-a0a8-4dfe-bdb7-d86db9f988e5">


4. 



------------------------------------------------TO BE DELETED-----------------------------------------------------------

* 1 for Addition - Adds the two integers.
* 2 for Subtraction - Subtracts the second integer from the first.
* 3 for Multiplication - Multiplies the two integers.
* 4 for Division - Divides the first integer by the second, also providing the remainder if applicable.

### Special Considerations:
In the case of mathematical operation 4, division, because dividing by zero is undefined, the script 
checks if the second integer (the denominator) is zero to prevent division by zero. And if the 
denominator is zero, the script notifies the user that the division is impossible.


## Input Validation & Notices :

_This is done at 3 points;_

1. The script checks if the user's input to the operation selection is valid for the mathematical operands 
(between 1 and 4).

```sh
if [[ $operation_number -lt 1 || $operation_number -gt 4 ]]; then
  echo -e "You haven't selected a proper mathematical option"
  exit 1
fi
```
 
2. The script checks if the user's input of the two integers to be operated on, are indeed integers.

```sh
[[ ! $first_number =~ ^-?[0-9]+$ ]]
```

3. The user is notified if option 4 (the division operand) is selected that the second number has to be the denominator.

```sh
if [ $operation_number -eq 4 ]; then
  echo -e "\e[31m!! Please note that your first integer is the numerator and the second number is the denominator !!\e[0m"
fi
```


## Error Handling

**Invalid Operation:** If the user inputs a number outside the range of 1-4 for the operation, the script will exit with an error message.

**Invalid Input:** If the user inputs a non-integer value for either of the numbers, the script will prompt them to enter a valid integer.

**Exit Codes**
- 0: Successful execution.
- 1: An invalid operation was selected.
