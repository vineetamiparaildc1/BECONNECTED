//
//  ProfileViewController.h
//  BECONNECTED
//
//  Created by indianic on 06/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profPicImgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
- (IBAction)btnProfilePicClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;


@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmailID;

@property (weak, nonatomic) IBOutlet UITextField *txt_UserName;

@property (weak, nonatomic) IBOutlet UITextField *txt_Password;

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg_Gender;


@end
