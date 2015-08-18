//
//  ViewController.h
//  BECONNECTED
//
//  Created by indianic on 30/07/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController

- (IBAction)btnFBSignInClicked:(id)sender;
- (IBAction)btnTwitterSignIn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

