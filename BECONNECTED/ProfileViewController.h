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

@end
