const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "66b2a8ef08a84cac99255a7b1e11f650",
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
                    "endpoint": "https://kfpkngsycnewzbmr6gywc2t4vy.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-c3fvyebo7ncfpdz4hodgnw3uoi"
                }
            }
        }
    },
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
                            "PoolId": "us-east-1:6c33cec7-8b54-4c4b-8596-75949ee048e1",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_MUSVTlXcP",
                        "AppClientId": "7b6pu0p7dfuj4sgmik355puo75",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "projectwriterv04c6239c4d-c6239c4d-dev.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "7b6pu0p7dfuj4sgmik355puo75",
                            "SignInRedirectURI": "app://",
                            "SignOutRedirectURI": "app://",
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
                        "AppId": "66b2a8ef08a84cac99255a7b1e11f650",
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
                        "ApiUrl": "https://kfpkngsycnewzbmr6gywc2t4vy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-c3fvyebo7ncfpdz4hodgnw3uoi",
                        "ClientDatabasePrefix": "projectwriterv04_API_KEY"
                    },
                    "projectwriterv04_AWS_IAM": {
                        "ApiUrl": "https://kfpkngsycnewzbmr6gywc2t4vy.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "projectwriterv04_AWS_IAM"
                    }
                }
            }
        }
    }
}''';