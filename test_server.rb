require 'aws-sdk'
require 'json'

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new('akid', 'secret')
})
# how it should be used?
creds = JSON.load(File.read('secrets.json'))
Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
