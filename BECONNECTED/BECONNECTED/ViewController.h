//
//  ViewController.h
//  BECONNECTED
//
//  Created by indianic on 30/07/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ViewController : UIViewController<GIDSignInDelegate,GIDSignInUIDelegate>
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
-(IBAction)btnSignInClicked:(id)sender;
- (IBAction)btnFBSignInClicked:(id)sender;
- (IBAction)btnTwitterSignIn:(id)sender;


@end

