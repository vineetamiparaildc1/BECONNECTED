//
//  FriendDetailsViewController.h
//  BECONNECTED
//
//  Created by indianic on 13/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;

@property(nonatomic,strong)NSString *Mobileno;
@property(nonatomic,strong)NSString *Fullname;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *Username;
@property(nonatomic,strong)NSString *Gender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrViewFriendDetails;
@property (weak, nonatomic) IBOutlet UIButton *btnBackClicked;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileno;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
