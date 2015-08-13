//
//  ProfileViewController.h
//  BECONNECTED
//
//  Created by indianic on 06/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrView;

@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;

@property (weak, nonatomic) IBOutlet UITextField *txt_selectCountry;

@property (weak, nonatomic) IBOutlet UIButton *btn_SelectCountry;

@property (weak, nonatomic) IBOutlet UITextField *txtFullName;

@property (weak, nonatomic) IBOutlet UITextField *txtStatus;

@property (weak, nonatomic) IBOutlet UITextField *txtEmailID;

@property (weak, nonatomic) IBOutlet UITextField *txt_UserName;

@property (weak, nonatomic) IBOutlet UITextField *txt_Password;

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg_Gender;

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNum;

@property (weak, nonatomic) IBOutlet UIView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumber;

@property (strong, nonatomic)  NSString *strMobileNumber;
@property (strong, nonatomic)  NSString *strCountryCode;
@property (strong, nonatomic)  NSString *strCountryName;



- (IBAction)btnProfilePicClicked:(id)sender;
@end
