require 'aws-sdk'
require 'json'

json_infos = JSON.load(File.read('TestInstanceIDs.json'))
Aws.config[:credentials] = Aws::Credentials.new(json_infos['AccessKeyId'], json_infos['SecretAccessKey'])
ec2 = Aws::EC2::Resource.new(region: 'eu-central-1', credentials: credentials)
      
i = ec2.instance(json_infos['InstanceID'])
    
if i.exists?
  case i.state.code
  when 0  # pending
    puts "#{id} is pending, so it will be running in a bit"
  when 16  # started
    puts "#{id} is already started"
  when 48  # terminated
    puts "#{id} is terminated, so you cannot start it"
  else
    i.start
  end
end