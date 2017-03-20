import boto3
import yaml


class AwsHandler(object):
    def __init__(self):
        self.ec2 = boto3.resource('ec2')
        self.obj_instance = self.ec2.Instance('id')

    def current_state(self):
        print("Current instance state: ", self.obj_instance.state)

    def create_instances(self):
        pass

    def stop_instances(self):
        pass

    def start_instances(self):
        pass
