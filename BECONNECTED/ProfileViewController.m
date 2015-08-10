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
{
    UIImagePickerController *Picker;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.scrView.contentSize = CGSizeMake(self.scrView.frame.size.width, 820);
    self.scrView.delegate = self;

    
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

                     
                     [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]] forState:(UIControlState)nil];
                     
                     
                     //_profPicImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]];
                 }
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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollViewToCenterOfScreen:textField];
}
-(void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat availableHeight = applicationFrame.size.height; // Remove area covered by keyboard
    
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0) {
        y = 0;
    }
    [_scrView setContentOffset:CGPointMake(0, y) animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.scrView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}
- (IBAction)btnProfilePicClicked:(id)sender {
    
    Picker = [[UIImagePickerController alloc] init];
    [Picker setDelegate:self];
    Picker.allowsEditing = YES;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take photo", @"Choose Existing", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        Picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else if (buttonIndex == 0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else if (buttonIndex == 1)
    {
        Picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:Picker animated:YES completion:NULL];
    }
    
    
    //[actionSheet release];;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *origionalImage =[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [_btnProfilePic setImage:origionalImage forState:(UIControlState)nil];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

@end
