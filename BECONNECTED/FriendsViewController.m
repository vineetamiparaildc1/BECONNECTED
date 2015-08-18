//
//  FriendsViewController.m
//  BECONNECTED
//
//  Created by indianic on 11/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendDetailsViewController.h"

@interface FriendsViewController (){
    
    NSArray *aArray;
    PFObject *objPF;
    NSArray *arrobjFriends;
    
}

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            aArray = [[NSArray alloc]initWithArray:objects];
            [_tblViewFriends reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
//    PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
//    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error)
//        {
//            arrobjFriends = [[NSArray alloc]initWithArray:objects];
//        }
//        else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
    
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return aArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
    
    
    
    _btnAddFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    for (int i=0; i<aArray.count; i++)
    {
        int y=5;
        _btnAddFriend.frame = CGRectMake(220, y, 110, 35);
        y=y+50;
    }
    
    //[cell.contentView addSubview:_btnAddFriend];
    _btnAddFriend.tag = indexPath.row + 1;
    
    for (int i=0; i<arrobjFriends.count; i++)
    {
        
        NSString *Temp=[[arrobjFriends objectAtIndex:i] objectForKey:@"reqstatus"];
        //NSString *Temp1=[[arrobjFriends objectAtIndex:i] objectForKey:@"isfriend"];
        
        if ([Temp isEqualToString:@"requestsent"])
        {
            [_btnAddFriend setImage:[UIImage imageNamed:@"RequestSent.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_btnAddFriend];
            [[NSUserDefaults standardUserDefaults] setObject:@"addfriend" forKey:@"RequestDetail"];
            
        }
         if([Temp isEqualToString:@"addfriend"])
        {
            [_btnAddFriend setImage:[UIImage imageNamed:@"AddFriend.png"] forState:UIControlStateNormal];
             [cell.contentView addSubview:_btnAddFriend];
            [[NSUserDefaults standardUserDefaults] setObject:@"requestsent" forKey:@"RequestDetail"];
         
        }
//         if ([Temp1 isEqualToString:@"true"])
//        {
//            [_btnAddFriend setImage:[UIImage imageNamed:@"Friends.png"] forState:UIControlStateNormal];
//            [cell.contentView addSubview:_btnAddFriend];
//        }
        
    }
        
            
        
        
    [_btnAddFriend addTarget:self action:@selector(TableBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        
    
    

    objPF = [aArray objectAtIndex:indexPath.row];
    
    PFFile *imageFile = [objPF objectForKey:@"profilepic"];
    NSLog(@"imageURL= %@",imageFile.url);
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        
        if (!error && imageData) {
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            
            UIImageView *imgView = (UIImageView*)[cell viewWithTag:200];
            imgView.image = image;
            imgView.layer.cornerRadius = imgView.frame.size.width / 2;
            imgView.clipsToBounds = YES;
            
        }
    }];

    
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:201];
    lblTitle.text =  [objPF objectForKey:@"fullname"];
    
    UILabel *lblTitle1 = (UILabel*)[cell viewWithTag:202];
    lblTitle1.text =  [objPF objectForKey:@"status"];
    
    return cell;
    
    
}

-(void)TableBtnClicked:(UIButton*)sender
{
    objPF = [aArray objectAtIndex:sender.tag-1];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"LoginUserID"];
    NSString *savedValue2 = [[NSUserDefaults standardUserDefaults] stringForKey:@"RequestDetail"];
    PFObject *gameScore = [PFObject objectWithClassName:@"Friends"];
    [gameScore setObject:savedValue forKey:@"userid"];
    [gameScore setObject:objPF.objectId forKey:@"friendid"];
    
    
    [gameScore setObject:[NSNumber numberWithBool:NO] forKey:@"isfriend"];
    
    
    [gameScore setObject:savedValue2 forKey:@"reqstatus"];
    
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [_tblViewFriends reloadData];
        }
        else
        {
            // There was a problem, check error.description
        }
    }];
    
    
    
}
- (IBAction)btnclicked:(id)sender
{
    PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            arrobjFriends = [[NSArray alloc]initWithArray:objects];
            [_tblViewFriends reloadData];
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

//Table view delegates
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    objPF = [aArray objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:[objPF objectId] forKey:@"FriendUserID"];
    FriendDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendDetailsViewController"];
    [self presentViewController:obj animated:YES completion:nil];
    
}

@end
