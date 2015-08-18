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
    NSString *strFriendDetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"FriendUserID"];
    NSString *strMapName= [[NSUserDefaults standardUserDefaults]objectForKey:@"MapName"];
    
    
   // [_txtMessagebox setInputAccessoryView:_txtfieldView];
    
    if (![strMapName isEqualToString:@""])
    {
        
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"fullname" equalTo:strMapName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objDetail, NSError *error){
             // Do something with the returned PFObject in the gameScore variable.
             
             _lblFriendsName.text = [[objDetail firstObject] objectForKey:@"fullname"];
             
             PFFile *imageFile = [[objDetail firstObject]objectForKey:@"profilepic"];
             [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                 if (!error && imageData) {
                     UIImage *image = [[UIImage alloc]initWithData:imageData];
                     [_imgViewProfilePic setImage:image];
                 }
             }];
         }];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"MapName"];
        
        
    }
    
    if (![strFriendDetail isEqualToString:@""])
    {
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
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"FriendUserID"];
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_txtMessagebox setInputAccessoryView:_txtfieldView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}






@end
