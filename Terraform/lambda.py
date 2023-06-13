import boto3
import json
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    try:
        table = dynamodb.Table('Team-Oak')
        
        name = event['name']
        email = event['email']
        location = event['location']
        phone = event['phone']
        education = event['education']
        
        response = table.put_item(
            Item={
                'name': "name",
                'email': "email",
                'location': "location",
                'phone': "phone",
                'education': "education"
            }
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Information saved successfully.',
                'response': response
            }),
        }
        
    except ClientError as e:
        print(e.response['Error']['Message'])
        return {
            'statusCode': 500,
            'body': json.dumps({
                'message': 'Error saving information',
                'error': str(e)
            }),
        }
