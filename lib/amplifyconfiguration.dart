const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:a85dd085-4262-4804-ade7-e84b60bd643e",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_iRgjgQeo1",
                        "AppClientId": "7o1bmuug8d9nh8u64srmo1oeqr",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "stm5f4n2ie79-dev.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "7o1bmuug8d9nh8u64srmo1oeqr",
                            "SignInRedirectURI": "myapp://",
                            "SignOutRedirectURI": "myapp://",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "2d6ae6b5ae93476ca5dcb4ae13922824",
                        "Region": "us-east-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-east-1"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://5mndy4z25fhchfs4ftn6umoahy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-h5osq6p6pneyjhn57ciny757ia",
                        "ClientDatabasePrefix": "projectwriterv04_API_KEY"
                    },
                    "projectwriterv04_AWS_IAM": {
                        "ApiUrl": "https://5mndy4z25fhchfs4ftn6umoahy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "projectwriterv04_AWS_IAM"
                    }
                }
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "2d6ae6b5ae93476ca5dcb4ae13922824",
                    "region": "us-east-1"
                },
                "pinpointTargeting": {
                    "region": "us-east-1"
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "projectwriterv04": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://5mndy4z25fhchfs4ftn6umoahy.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-h5osq6p6pneyjhn57ciny757ia"
                }
            }
        }
    }
}''';