//
//  ChatDetailsViewController.h
//  BECONNECTED
//
//  Created by Engage Beyond-4 on 8/18/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse.h>

@interface ChatDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblFriendsName;

@property (weak, nonatomic) IBOutlet UILabel *lblLastSeen;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfilePic;

@property (weak, nonatomic) IBOutlet UITextField *txtMessagebox;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end
