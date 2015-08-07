//
//  ProfileViewController.m
//  BECONNECTED
//
//  Created by indianic on 06/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
        
         if (!error)
         {
             NSLog(@"%@",objects);
             
             [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                 
                 NSLog(@"Retrieved data");
                 
                 if (!error) {
                     PFFile *file = [object objectForKey:@"profilepic"];
                     NSLog(@"%@",file.url);

                     _profPicImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]];                 }
             }];

             
         }
         
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
    //NSURL *imageURL = [NSURL URLWithString:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xta1/v/t1.0-1/p200x200/1376375_785829758095367_5053181949280406371_n.jpg?oh=4404490bd8fefcd53eeabe0ce235d6d9&oe=5648C3A9&__gda__=1447688116_9c89994f2fb84898eeea175dbe44b648"];
    //NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    //_profPicImgView.image = [UIImage imageWithData:imageData];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UpdateButtonClicked:(id)sender
{
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];
    
    ViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}

@end
