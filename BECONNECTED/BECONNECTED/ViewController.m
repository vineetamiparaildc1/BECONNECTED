//
//  ViewController.m
//  BECONNECTED
//
//  Created by indianic on 30/07/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>
#import "SignUpViewController.h"
#import <MessageUI/MessageUI.h>
#import "ProfileViewController.h"
#import <Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Facebook

- (IBAction)btnFBSignInClicked:(id)sender
{
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"Facebook" forKey:@"LoginProfile"];
        [self jumptoProfile];
    }
    else
    {
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        login.loginBehavior= FBSDKLoginBehaviorSystemAccount;
        [login logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Error");
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"Facebook" forKey:@"LoginProfile"];
                [self jumptoProfile];
                
            }
        }];
    }
}

- (IBAction)btnTwitterSignIn:(id)sender {
    
    if ([[Twitter sharedInstance]session])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"Twitter" forKey:@"LoginProfile"];
        [self jumptoProfile];
    }else{
        
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (!error)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"Twitter" forKey:@"LoginProfile"];
                [self jumptoProfile];
                
            }
            else
            {
                NSLog(@"Login unsuccess with below error :- \n%@",error.description);
            }
        }];
    }
}



-(void)jumptoProfile
{
    ProfileViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}


-(IBAction)btn_SignUpClicked:(id)sender
{
    SignUpViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}




@end
