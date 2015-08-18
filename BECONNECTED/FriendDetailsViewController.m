//
//  FriendDetailsViewController.m
//  BECONNECTED
//
//  Created by Rohan Meghani on 12/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "FriendDetailsViewController.h"
#import "FriendsViewController.h"
#import "ChatDetailsViewController.h"

@interface FriendDetailsViewController ()

@end

@implementation FriendDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrViewFriendDetails.contentSize = CGSizeMake(self.scrViewFriendDetails.frame.size.width, 568);
    
    NSString *strFriendDetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"FriendUserID"];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:strFriendDetail block:^(PFObject *objDetail, NSError *error)
     {
         // Do something with the returned PFObject in the gameScore variable.
         _lblMobileno.text = [NSString stringWithFormat:@"%@ %@",[objDetail objectForKey:@"countrycode"],[objDetail objectForKey:@"mobileno"]];
         _lblFullName.text = [objDetail objectForKey:@"fullname"];
         _lblUsername.text = [objDetail objectForKey:@"username"];
         _lblStatus.text = [objDetail objectForKey:@"status"];
         _lblEmail.text = [objDetail objectForKey:@"email"];
         _lblGender.text =[objDetail objectForKey:@"gender"];

         NSArray *titleArray = [[objDetail objectForKey:@"fullname"] componentsSeparatedByString:@" "];
         NSString *title = [titleArray firstObject];
         _lblTitle.text = [NSString stringWithFormat:@"%@'s Info",title];
         
         
         PFFile *imageFile = [objDetail objectForKey:@"profilepic"];
         [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
             
             if (!error && imageData) {
                 UIImage *image = [[UIImage alloc]initWithData:imageData];
                 [_btnProfilePic setImage:image forState:UIControlStateNormal];
             }
         }];
     }];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnBackClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (IBAction)btn_Chatclicked:(id)sender
{
    ChatDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailsViewController"];
    [self presentViewController:obj animated:YES completion:nil];

}

- (IBAction)btn_callClicked:(id)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_lblMobileno.text]];
}



- (IBAction)btn_LocationClicked:(id)sender {
}





@end
