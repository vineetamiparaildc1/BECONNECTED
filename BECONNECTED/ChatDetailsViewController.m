//
//  ChatDetailsViewController.m
//  BECONNECTED
//
//  Created by Engage Beyond-4 on 8/18/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ChatDetailsViewController.h"

@implementation ChatDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollView.contentSize = CGSizeMake(320,449);
    NSString *strFriendDetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"FriendUserID"];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:strFriendDetail block:^(PFObject *objDetail, NSError *error)
     {
         // Do something with the returned PFObject in the gameScore variable.
         
         _lblFriendsName.text = [objDetail objectForKey:@"fullname"];
         
         PFFile *imageFile = [objDetail objectForKey:@"profilepic"];
         [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
             
             if (!error && imageData) {
                 UIImage *image = [[UIImage alloc]initWithData:imageData];
                 [_imgViewProfilePic setImage:image];
             }
         }];
     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
