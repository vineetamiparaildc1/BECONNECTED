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
    NSDictionary *aDict;
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
    
    // Do any additional setup after loading the view.
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
    
    // add friend button
    UIButton *addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addFriendButton.frame = CGRectMake(255.0f, 15.0f, 62.0f, 34.0f);
    [addFriendButton setImage:[UIImage imageNamed:@"friend.png"] forState:UIControlStateNormal];
    
    //   [addFriendButton setTitle:@"+Friend" forState:UIControlStateNormal];
    [addFriendButton setImage:[UIImage imageNamed:@"man-profile.png"] forState:UIControlStateSelected];
    
    [cell addSubview:addFriendButton];
    [addFriendButton addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];    addFriendButton.tag = indexPath.row;
    
    
    
    
    //cell.addFriendButton.tag = indexPath.row;
    //cell.textLabel.text =
    
    
    
    aDict = [aArray objectAtIndex:indexPath.row];
    
    
    PFFile *imageFile = [aDict objectForKey:@"profilepic"];
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
    lblTitle.text =  [aDict objectForKey:@"fullname"];
    
    UILabel *lblTitle1 = (UILabel*)[cell viewWithTag:202];
    lblTitle1.text =  [aDict objectForKey:@"status"];
    
    return cell;
}
-(void)yourButtonClicked:(UIButton*)sender{
   // NSLog(@"Tag= %ld",(long)sender.tag);
    
}

//Table view delegates
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    aDict = [aArray objectAtIndex:indexPath.row];
    
    FriendDetailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendDetailsViewController"];
    obj.Mobileno= [aDict objectForKey:@"mobileno"];
    obj.Fullname = [aDict objectForKey:@"fullname"];
    obj.Username= [aDict objectForKey:@"username"];
    obj.Status= [aDict objectForKey:@"status"];
    obj.Email= [aDict objectForKey:@"email"];
    obj.Gender= [aDict objectForKey:@"gender"];
    PFFile *imageFile = [aDict objectForKey:@"profilepic"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        
        if (!error && imageData) {
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            [obj.btnProfilePic setImage:image forState:UIControlStateNormal];
        }
    }];
    [self presentViewController:obj animated:YES completion:nil];
    
}
@end
