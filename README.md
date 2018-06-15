# terraform-single-instance


Started creating all the components manually to grasp what was needed if i was to automate most of the infrastructure through
terraform.

Created EC2/Security gruops/IGW/Subnets/Route tables
SSH onto the EC2 instance installed apache ( https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html )
CA signer using Let's Encrypt and Certbot ( https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-an-instance.html#letsencrypt)
The http request should be redirected to https.
Initially failed to register the DNS as AWS dns is blacklisted as they are "throwaway" accounts
Registered a DNS through route53 - jlamhelloworld.co.uk
Create Record set, A record to point to the ip address. for both root domain and www
Later on i did attach an alias to the application loadbalancer with only takes in https requests
I should have also created a ASG to go with the ALB as they compliment each other. But the userdata needed to be correct before i could spin up boxes on the fly.

Moving on to terraform.

Created a single instance via terraform with userdata attached, to automate most of it. To installed apache and download certbot packages.
Unable to amend Apache configuration file. Was thinking to either have it pull from S3 but as this needs to be dynamic because of the server
name. It maybe able to variablise it ? 

The rest of the steps will be manual unfortunately but i dont believe we should be logging onto the box to change any config around or it should be the bare minimal

Tried to create asg and alb via terraform. Unable to complete, unsure how to do this, did start creating aws_launch_configuration /aws_alb / 
security groups eventually ran out of time. 

And finally the urls that sit behind the alb

https://jlamhelloworld.co.uk/

https://www.jlamhelloworld.co.uk/
