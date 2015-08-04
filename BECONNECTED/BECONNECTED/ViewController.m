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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [GIDSignIn sharedInstance].uiDelegate = self;
    
    //Twitter
//    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
//        // play with Twitter session
//    }];
//    logInButton.center = self.view.center;
//    [self.view addSubview:logInButton];

//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   // [myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnGoogleSignInClicked:(id)sender
{
    GIDSignIn *googleSignIn = [GIDSignIn sharedInstance];
    //    googleSignIn.shouldFetchBasicProfile = YES;
    //    googleSignIn.clientID = @"870997164438-dtct6364sfepbhm6v9245oahqcn4mntj.apps.googleusercontent.com";
    //    googleSignIn.scopes = @[@"https://www.googleapis.com/auth/plus.login"];
    googleSignIn.delegate = self;
    [googleSignIn signIn];
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    NSLog(@"Name = %@",name);
    NSLog(@"Email = %@",email);
    NSLog(@"UserID = %@",userId);
    NSLog(@"idToken = %@",idToken);
    
}
//Facebook

- (IBAction)btnFBSignInClicked:(id)sender
{
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [self getFbInfo];
    }
    else{
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        login.loginBehavior= FBSDKLoginBehaviorSystemAccount;
        [login logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Error");
            }else{
                [self getFbInfo];
            }
        }];
    }
}

- (IBAction)btnTwitterSignIn:(id)sender {
    
    if ([[Twitter sharedInstance]session]) {
        [self getTWInfo];
    }else{
        
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (!error) {
                [self getTWInfo];
            }else
                
            {
                
                NSLog(@"Login unsuccess with below error :- \n%@",error.description);
            }
        }];
    }
}
-(void)getTWInfo
{
    
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[[[Twitter sharedInstance] session] userID]
                                              completion:^(TWTRUser *user,
                                                           NSError *error)
     {
         
         if (![error isEqual:nil]) {
             NSLog(@"Twitter info   -> user = %@",user);
             NSLog(@"Name = %@",user.name);
             NSLog(@"Profilepic URL = %@",user.profileImageMiniURL);
         }
         
     }];
}


-(void)getFbInfo{
    
    [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,picture.type(large),email,birthday, bio,location"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error)
        {
            NSLog(@"Result = %@",result);
            //[FBSDKAccessToken setCurrentAccessToken:nil];
        }
    }];
}


-(IBAction)btn_SignUpClicked:(id)sender
{
    SignUpViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}




@end
