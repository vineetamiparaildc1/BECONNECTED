//
//  ProfileViewController.m
//  BECONNECTED
//
//  Created by indianic on 06/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
        
         if (!error)
         {
             NSLog(@"%@",objects);
         }
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
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

@end
