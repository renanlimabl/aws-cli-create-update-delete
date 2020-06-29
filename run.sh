#1º first step is create a archive of security, polity of security (JSON), what services her have permission...

#2º second step is create a role of security in AWS using IAM
aws iam create-role \
  --role-name lambda-exemplo \
  --assume-role-policy-document file://politicas.json \
  | tee logs/role.log

#3º third step is create the arquive of contents and zip
zip function.zip index.js

#4º fourth step is create my lambda function
aws lambda create-function \
  --function-name hello-cli \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs12.x \
  --role arn:aws:iam::239487228787:role/lambda-exemplo \
  | tee logs/lambda-create.log

# 5º fifth step, invoke lambda!
aws lambda invoke \
  --function-name hello-cli \
  --log-type Tail \
  logs/lambda-exec.log

# !! FOR UPDATE zip again
zip function.zip index.js

#7º FOR UPDATE the lambda 
aws lambda update-function-code \
  --zip-file fileb://function.zip \
  --function-name hello-cli \
  --publish \
  | tee logs/lambda-update.log

#8º FOR UPDATE invoke again e see the result 
aws lambda invoke \
  --function-name hello-cli \
  --log-type Tail \
  logs/lambda-exec-update.log

# !! for delete lambda, in case of this course is import.
aws lambda delete-function \
  --function-name hello-cli

# !! for delete iam, in case of this course is import.
aws iam delete-role \
  --role-name lambda-exemplo