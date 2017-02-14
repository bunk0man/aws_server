require 'aws-sdk'
require 'json'

creds = JSON.load(File.read('TestInstanceIDs.json'))
Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])

# list buckets in Amazon S3
# s3 = Aws::S3::Client.new
# resp = s3.list_buckets
# resp.buckets.map(&:name)
#=> ["bucket-1", "bucket-2", ...]
