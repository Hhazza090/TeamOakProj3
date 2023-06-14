import boto3
import json
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    try:
        table = dynamodb.Table('Team-Oak-project-3')
        
        name = event['name']
        email = event['email']
        location = event['location']
        option = event['option']  # Updated key name
        experience = event['experience']
        education = event['education']
        phone = event['phone']
        
        response = table.put_item(
            Item={
                'name': name,
                'email': email,
                'location': location,
                'option': option,
                'experience': experience,
                'education': education,
                'phone': phone
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
