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
#import <TwitterKit/TwitterKit.h>
#import "NotificationsViewController.h"

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

    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"LoginProfile"];
    
    
    if([savedValue isEqualToString:@"Facebook"])
    {
        [self getFbInfo];
    }
    else if ([savedValue isEqualToString:@"Twitter"])
    {
        [self getTWInfo];
    }
    
    
    
//    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//        
//         if (!error)
//         {
//             NSLog(@"%@",objects);
//             
//             [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//                 
//                 NSLog(@"Retrieved data");
//                 
//                 if (!error) {
//                     PFFile *file = [object objectForKey:@"profilepic"];
//                     NSLog(@"%@",file.url);
//
//                     
//                     [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]] forState:(UIControlState)nil];
//                     
//                     
//                     //_profPicImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]];
//                 }
//             }];
//
//             
//         }
//         
//         else
//         {
//             NSLog(@"Error: %@ %@", error, [error userInfo]);
//         }
//     }];
    
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
        
    // [self performSegueWithIdentifier:@"pushview" sender:nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Required Field" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if ([_txt_UserName.text isEqualToString:@"User Name"] || _txt_UserName.text.length == 0)
    {
        alert.message=@"Please Enter Username";
        [alert show];
    }
    
    else if ([_txt_Password.text isEqualToString:@"Password"] || _txt_Password.text.length == 0)
    {
        alert.message=@"Please Enter Password";
        [alert show];
    }
    else if ([_txtEmailID.text isEqualToString:@"Email-ID"] || _txtEmailID.text.length == 0)
    {
        alert.message=@"Please Enter Email-ID";
        [alert show];
    }
    else if([_txtFirstName.text isEqualToString:@"First Name"] || _txtFirstName.text.length == 0)
    {
        alert.message=@"Please Enter FirstName";
        [alert show];
    }
    else if([_txtLastName.text isEqualToString:@"Last Name"] || _txtLastName.text.length == 0)
    {
        alert.message=@"Please Enter LastName";
        [alert show];
    }
    else if([_txtCountryName.text isEqualToString:@"Select Country        >"] || _txtCountryName.text.length == 0)
    {
        alert.message=@"Please Enter CountryName";
        [alert show];
    }
    else if([_txtMobileNum.text isEqualToString:@"First Name"] || _txtMobileNum.text.length == 0)
    {
        alert.message=@"Please Enter MobileNumber";
        [alert show];
    }else{
        
        //NSDictionary *temp= result;
        PFUser *user=[PFUser user];
        user.username = _txt_UserName.text;
        user.password = _txt_Password.text;
        user.email =  _txtEmailID.text;
        NSLog(@"Email = %@",_txtEmailID.text);
        
        [user setObject:_txtFirstName.text forKey:@"firstname"];
        [user setObject:_txtLastName.text forKey:@"lastname"];
        [user setObject:_txtCountryName.text forKey:@"countryname"];
        [user setObject:_txtMobileNum.text forKey:@"mobileno"];
        
        
        
        [user signUpInBackgroundWithBlock:^(BOOL success,NSError *error)
         {
             if (success)
             {
                 NSLog(@"User Saved");
                 {
                     //Getting FBImageUrl From Dictionary Results
                     //                             NSMutableDictionary *DicFbImageUrl = result;
                     //                             DicFbImageUrl = [DicFbImageUrl objectForKey:@"picture"];
                     //                             DicFbImageUrl = [DicFbImageUrl objectForKey:@"data"];
                     //                             NSString *StrFbImageUrl = [DicFbImageUrl objectForKey:@"url"];
                     //
                     //
                     //
                     //                             NSURL *imageURL = [NSURL URLWithString:StrFbImageUrl];
                     //                             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                     //                             UIImage *image = [UIImage imageWithData:imageData];
                     //
                     //                             [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:StrFbImageUrl]]] forState:(UIControlState)nil];
                     //
                     //
                     //                             //For getting image name for PFFileName
                     //                             NSArray *temparr = [StrFbImageUrl componentsSeparatedByString:@"/"];
                     //                             StrFbImageUrl = [temparr lastObject];
                     //                             temparr = [StrFbImageUrl componentsSeparatedByString:@"?"];
                     
                     UIImage *image = _btnProfilePic.imageView.image;
                     NSData *imageData = UIImageJPEGRepresentation(image,1.0);
                     PFFile *imageFile = [PFFile fileWithName:@"ProfilePic" data:imageData];
                     [user setObject:imageFile forKey:@"profilepic"];
                     
                     
                     [imageFile saveInBackground];
                     
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                      {
                          if (!error)
                          {
                              //                                      ViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                              //                                      [self presentViewController:obj animated:YES completion:nil];
                              
                          }
                      }];
                     
                     
                     
                 }
                 
             }
             
         }];
        
        
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scrollViewToCenterOfScreen:textField];
     textField.text=@"";
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
    
    UIImage *origionalImage =[info objectForKey:UIImagePickerControllerEditedImage];
    
    [_btnProfilePic setImage:origionalImage forState:(UIControlState)nil];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSURL *imageURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"URL = %@",imageURL);
    
    PFUser *user = [PFUser currentUser];
    NSData *imageData = UIImageJPEGRepresentation(origionalImage,1.0);
    PFFile *imageFile = [PFFile fileWithName:@"ProfilePic.jpg" data:imageData];
    [imageFile saveInBackground];
    
    [user setObject:imageFile forKey:@"profilepic"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error)
        {
            
            
        }
    }];
    
    
}




-(void)getFbInfo
{
    
    [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,picture.type(large),email,birthday, bio,location"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error)
        {
            NSLog(@"Result = %@",result);
            NSMutableDictionary *DicFbImageUrl = result;

            _txt_UserName.text= [DicFbImageUrl objectForKey:@"name"];
            
            DicFbImageUrl = [DicFbImageUrl objectForKey:@"picture"];
            DicFbImageUrl = [DicFbImageUrl objectForKey:@"data"];
            NSString *StrFbImageUrl = [DicFbImageUrl objectForKey:@"url"];
            
            [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:StrFbImageUrl]]] forState:(UIControlState)nil];
            
        }
    }];
    
}


-(void)getTWInfo
{
    
    [[[Twitter sharedInstance] APIClient] loadUserWithID:[[[Twitter sharedInstance] session] userID]
                                              completion:^(TWTRUser *user,
                                                           NSError *error)
     {
         
         if (![error isEqual:nil]) {
             
             _txt_UserName.text=[NSString stringWithFormat:@"%@",user];
             _txtFirstName.text = user.name;
             [_btnProfilePic setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.profileImageLargeURL]]] forState:(UIControlState)nil];
         }
         
     }];
}

@end
