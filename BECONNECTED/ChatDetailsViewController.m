//
//  ChatDetailsViewController.m
//  BECONNECTED
//
//  Created by Engage Beyond-4 on 8/18/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ChatDetailsViewController.h"

@implementation ChatDetailsViewController
{
    UITextField *txtTypeMessage;
    UIView *accessoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *strFriendDetail = [[NSUserDefaults standardUserDefaults]objectForKey:@"FriendUserID"];
    NSString *strMapName= [[NSUserDefaults standardUserDefaults]objectForKey:@"MapName"];
    
    
    
    if (!(strMapName == nil))
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
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"MapName"];
        
        
    }
    
    if (!(strFriendDetail == nil))

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
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"FriendUserID"];
    }
    
    
    accessoryView=[[UIView alloc]init];
    accessoryView.frame=CGRectMake(0,0, 320,30);
    
    UIButton *btnMedia = [[UIButton alloc]init];
    btnMedia.frame=CGRectMake(5,3, 25,25);
    [btnMedia setBackgroundImage:[UIImage imageNamed:@"insert.png"] forState:UIControlStateNormal];
    [accessoryView addSubview:btnMedia];
    
    UIButton *btnCamera = [[UIButton alloc]init];
    btnCamera.frame=CGRectMake(250,3, 25,25);
    [btnCamera setBackgroundImage:[UIImage imageNamed:@"camera.jpeg"] forState:UIControlStateNormal];
    [accessoryView addSubview:btnCamera];
    
    UIButton *btnMic = [[UIButton alloc]init];
    btnMic.frame=CGRectMake(286,3, 25,25);
    [btnMic setBackgroundImage:[UIImage imageNamed:@"mic.png"] forState:UIControlStateNormal];
    [accessoryView addSubview:btnMic];
    
    txtTypeMessage = [[UITextField alloc]init];
    txtTypeMessage.frame=CGRectMake(43, -2, 197, 30);
    txtTypeMessage.delegate=self;
    txtTypeMessage.tag=5;
    txtTypeMessage.borderStyle=UITextBorderStyleRoundedRect;
    [accessoryView addSubview:txtTypeMessage];
    
    _txtMessagebox.inputAccessoryView = accessoryView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender
{
    [_txtMessagebox resignFirstResponder];
    [txtTypeMessage resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txtTypeMessage) {
        
        [txtTypeMessage becomeFirstResponder];
        [_txtMessagebox resignFirstResponder];
    }
    if (textField==_txtMessagebox) {
        
        [_txtMessagebox becomeFirstResponder];
        [txtTypeMessage resignFirstResponder];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtTypeMessage) {
        
        _txtMessagebox.text = [textField.text stringByAppendingString:string];
        //txtTypeMessage.text=_txtMessagebox.text;
    }
    if (textField==_txtMessagebox)
    {
        
        txtTypeMessage.text = [textField.text stringByAppendingString:string];
        //_txtMessagebox.text=txtTypeMessage.text;
    }
   
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}






@end
