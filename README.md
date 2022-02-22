## Readme to install and run this AWS with Terraform project

1) Create a AWS account and setup aws cli with some iam user granted with AdministratorAccess (only for this test, obviously, never use that in a production environment)

2) Install terraform (https://www.terraform.io/) and configure it with the previous aws 

3) Get the repository (git clone https://github.com/lancedon/aws-stream-terraform.git)

4) On the project folder, go to tf folder and run:
	- terraform plan
	- terraform apply (yes)

5) After that, go to AWS console > Lambda Functions > ApiLambda > click on add trigger  (I know that is possible include on Terraform, but until know I do not found the way to do it). In that screen select:
	- Api Gateway
	- api-http
	- $default
	- open
	And click on "add" to include the trigger on your function

6) Click on the Api Gateway trigger and copy the Api Endpoint (in my case will be:  https://7qrbzounqg.execute-api.us-east-1.amazonaws.com/ApiLambda)

7) Access to your browser or any cli command, like curl, the URL (the url you get on step 6 + the get parameters): https://7qrbzounqg.execute-api.us-east-1.amazonaws.com/ApiLambda?user_id=1&user_activity=page_view&user_score=10&user_timespent=15

8) Now you can go on your the AWS console > CloudWatch > Log groups and check the log about the lambda functions ApiLambda and ProcessKinesisRecords. You will see the follows:
	- When you access the url, the api gateway trigged the ApiLambda Function
	- The ApiLambda function start a stream on Kinesis "lambda-stream"
	- The stream "lambda-stream" will trigger the lambda function "ProcessKinesisRecords"
	- This function will filder the data with use the parameter user_timespent and if this parameter was bigger then 0, will start a stream to "lambda-stream-2" with all data.
