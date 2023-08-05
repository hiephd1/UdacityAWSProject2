def lambda_handler(event, context):
    print("Lambda function handler!")
    message = 'Udacity learning, project 2 from {}'.format(event['name'])
    return {
        'message' : message
    }
