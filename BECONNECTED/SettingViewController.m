//
//  SettingViewController.m
//  BECONNECTED
//
//  Created by indianic on 10/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "SettingViewController.h"
#import "ProfileViewController.h"
#import <audiotoolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>
#import "ViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnProfileClicked:(id)sender
{
    ProfileViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}


- (IBAction)btnLogoutClick:(id)sender
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"LoginProfile"];

    if([savedValue isEqualToString:@"Facebook"])
    {
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [FBSDKProfile setCurrentProfile:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"LoginProfile"];
    }
    else if ([savedValue isEqualToString:@"Twitter"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"LoginProfile"];
        [[Twitter sharedInstance]logOut];
    }
    else
    {
    }
    ViewController *obj  =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:obj animated:YES completion:nil];

}


- (IBAction)btnAboutUsClicked:(id)sender {
}


- (IBAction)btnContactUsCicked:(id)sender {
}


- (IBAction)btnFeedBackQueriesClicked:(id)sender {
}


- (IBAction)btnFollowUsClicked:(id)sender {
}


- (IBAction)btnTellaFriendClicked:(id)sender {
}

- (IBAction)SwitchClicked:(UISwitch *)sender
{
    if (sender.tag==1)
    {
        if(sender.on)
        {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
        {
            //AudioManager amanager=(AudioManager)getSystemService(Context.AUDIO_SERVICE);
            //amanager.setRingerMode(AudioManager.RINGER_MODE_SILENT);
        }
       
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
}






@end
