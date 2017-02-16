require 'aws-sdk'
require 'base64'
require 'json'

# User code that's executed when the instance starts
# Not finished yet
infos = JSON.load(File.read('TestInstanceIDs.json'))

script = ''

encoded_script = Base64.encode64(script)

ec2 = Aws::EC2::Resource.new(region: 'eu-central-1')

instance = ec2.create_instances({
  image_id: 'IMAGE_ID',
  min_count: 1,
  max_count: 1,
  key_name: 'MyGroovyKeyPair',
  security_group_ids: [creds['SevurityGroupID']],
  user_data: encoded_script,
  instance_type: 't2.micro',
  placement: {
    availability_zone: 'eu-central-1'
  },
  subnet_id: 'SUBNET_ID',
  network_interfaces: [{
    device_index: 0,
    associate_public_ip_address: true
  }],
  iam_instance_profile: {
    arn: 'arn:aws:iam::' + 'ACCOUNT_ID' + ':instance-profile/aws-opsworks-ec2-role'
  }
})

# Wait for the instance to be created, running, and passed status checks
ec2.client.wait_until(:instance_status_ok, {instance_ids: [instance[0].id]})

# Name the instance 'ExampleInstance' and give it the Group tag 'ExampleGroup'
instance.create_tags({ tags: [{ key: 'Name', value: 'ExampleInstance' }, { key: 'Group', value: 'ExampleGroup' }]})

puts instance.id