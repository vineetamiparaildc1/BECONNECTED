//
//  FriendDetailsViewController.m
//  BECONNECTED
//
//  Created by Rohan Meghani on 12/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "FriendDetailsViewController.h"
#import "FriendsViewController.h"


@interface FriendDetailsViewController ()

@end

@implementation FriendDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrViewFriendDetails.contentSize = CGSizeMake(self.scrViewFriendDetails.frame.size.width, 820);
    
    _lblMobileno.text = _Mobileno;
    _lblFullName.text = _Fullname;
    _lblUsername.text = _Username;
    _lblStatus.text = _Status;
    _lblEmail.text = _Email;
    _lblGender.text =_Gender ;
    
    NSArray *titleArray = [_Fullname componentsSeparatedByString:@" "];
    NSString *title = [titleArray firstObject];
    _lblTitle.text = [NSString stringWithFormat:@"%@'s Info",title];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnBackClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}
@end
