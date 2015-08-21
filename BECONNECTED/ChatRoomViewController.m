//
//  ChatRoomViewController.m
//  BECONNECTED
//
//  Created by indianic on 11/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "ChatDetailsViewController.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController
{
    NSArray *arrObjFriends;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends"];
    [query whereKey:@"isfriend" equalTo:[NSNumber numberWithBool:YES]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            arrObjFriends = [[NSArray alloc]initWithArray:objects];
            [_tblFriends reloadData];
            
            
        } else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrObjFriends.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
    
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:201];
    lblTitle.text =  [[arrObjFriends objectAtIndex:indexPath.row] objectForKey:@"friendname"];
    
    UILabel *lblTitle1 = (UILabel*)[cell viewWithTag:202];
    lblTitle1.text =  [[arrObjFriends objectAtIndex:indexPath.row] objectForKey:@"friendstatus"];
    
    
    PFFile *imageFile = [[arrObjFriends objectAtIndex:indexPath.row] objectForKey:@"friendprofilepic"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        
        if (!error && imageData) {
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            
            UIImageView *imgView = (UIImageView*)[cell viewWithTag:200];
            imgView.image = image;
            imgView.layer.cornerRadius = imgView.frame.size.width / 2;
            imgView.clipsToBounds = YES;
            
        }
    }];
    
    
    UIButton *btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    for (int i=0; i<arrObjFriends.count; i++)
    {
        int y=10;
        btnDetail.frame = CGRectMake(280, y, 30, 30);
        y=y+50;
    }
    
    btnDetail.tag = indexPath.row + 1;
    [btnDetail setBackgroundImage:[UIImage imageNamed:@"red-arrow.png"] forState:UIControlStateNormal];
    [cell.contentView addSubview:btnDetail];
    
    [btnDetail addTarget:self action:@selector(DetailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
     
    return cell;
    
}


//Table view delegates
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults]setObject:[[arrObjFriends objectAtIndex:indexPath.row]valueForKey:@"friendid"] forKey:@"FriendUserID"];
    ChatDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailsViewController"];
    [self presentViewController:obj animated:YES completion:nil];
    
}

-(void)DetailBtnClicked:(UIButton*)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:[[arrObjFriends objectAtIndex:sender.tag-1] valueForKey:@"friendid"] forKey:@"FriendUserID"];
    ChatDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailsViewController"];
    [self presentViewController:obj animated:YES completion:nil];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
