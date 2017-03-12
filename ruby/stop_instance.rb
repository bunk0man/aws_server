require 'aws-sdk'
require 'json'

json_infos = JSON.load(File.read('TestInstanceIDs.json'))

creds = Aws::Credentials.new(json_infos['AccessKeyId'],
                             json_infos['SecretAccessKey'])

ec2 = Aws::EC2::Resource.new(region: 'eu-central-1', credentials: creds)
      
i = ec2.instance(json_infos['InstanceID'])
    
if i.exists?
  case i.state.code
  when 48  # terminated
    puts "#{id} is terminated, so you cannot stop it"
  when 64  # stopping
    puts "#{id} is stopping, so it will be stopped in a bit"
  when 89  # stopped
    puts "#{id} is already stopped"
  else
    i.stop
  end
end