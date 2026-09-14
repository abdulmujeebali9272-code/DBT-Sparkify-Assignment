-- Step 1: create the integration
use role accountadmin;

create or replace storage integration sparkify_s3_int
  type = external_stage
  storage_provider = 'S3'
  enabled = true
  storage_aws_role_arn = 'arn:aws:iam::<account-id>:role/snowflake-sparkify-role'
  storage_allowed_locations = ('s3://sparkify-dwh-smit/');

-- Step 2: read the values Snowflake generated
desc integration sparkify_s3_int;

-- Take STORAGE_AWS_IAM_USER_ARN and STORAGE_AWS_EXTERNAL_ID from the output
-- and create an IAM role in AWS named snowflake-sparkify-role with this
-- custom trust policy, plus the AmazonS3ReadOnlyAccess policy:
--
-- {
--   "Version": "2012-10-17",
--   "Statement": [{
--     "Effect": "Allow",
--     "Principal": { "AWS": "<STORAGE_AWS_IAM_USER_ARN>" },
--     "Action": "sts:AssumeRole",
--     "Condition": {
--       "StringEquals": { "sts:ExternalId": "<STORAGE_AWS_EXTERNAL_ID>" }
--     }
--   }]
-- }

-- Step 3: grant usage and create the stage
grant usage on integration sparkify_s3_int to role sysadmin;

use role sysadmin;
use database sparkify;
use schema raw;
use warehouse sparkify_wh;

create or replace file format json_ff type = json;

create or replace stage sparkify.raw.s3_stage
  storage_integration = sparkify_s3_int
  url = 's3://sparkify-dwh-smit/'
  file_format = json_ff;

list @sparkify.raw.s3_stage;