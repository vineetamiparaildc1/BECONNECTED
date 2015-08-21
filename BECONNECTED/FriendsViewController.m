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
    PFObject *objQueryResult;
    NSString *strUserid;
    UIImageView *imgView;
    BOOL isfriends;
}

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    strUserid = [[NSUserDefaults standardUserDefaults]objectForKey:@"LoginUserID"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" notEqualTo:strUserid];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            aArray = [[NSArray alloc]initWithArray:objects];
            [_tblViewFriends reloadData];
            [self ReloadTable];
            
        } else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
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
    
    objPF = [aArray objectAtIndex:indexPath.row];
    NSString *strfriendid=objPF.objectId;
    
    PFFile *imageFile = [objPF objectForKey:@"profilepic"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        
        if (!error && imageData) {
            UIImage *image = [[UIImage alloc]initWithData:imageData];
            
            imgView = (UIImageView*)[cell viewWithTag:200];
            imgView.image = image;
            imgView.layer.cornerRadius = imgView.frame.size.width / 2;
            imgView.clipsToBounds = YES;
            
        }
    }];
    
    
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:201];
    lblTitle.text =  [objPF objectForKey:@"fullname"];
    
    UILabel *lblTitle1 = (UILabel*)[cell viewWithTag:202];
    lblTitle1.text =  [objPF objectForKey:@"status"];
    
    
    
    _btnAddFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    for (int i=0; i<aArray.count; i++)
    {
        int y=5;
        _btnAddFriend.frame = CGRectMake(220, y, 100, 35);
        y=y+50;
    }
    
    _btnAddFriend.tag = indexPath.row + 1;
    
    
    if (arrobjFriends.count == 0)
    {
        [_btnAddFriend setImage:[UIImage imageNamed:@"AddFriend.png"] forState:UIControlStateNormal];
    }
    else
    {
            for (int i=0; i<arrobjFriends.count; i++)
            {
                
                NSString *strreqstatus=[[arrobjFriends objectAtIndex:i] objectForKey:@"reqstatus"];
                //BOOL isfriend=[[arrobjFriends objectAtIndex:i] objectForKey:@"isfriend"];
                NSString *strreqtype=[[arrobjFriends objectAtIndex:i] objectForKey:@"reqtype"];
                NSArray *objArrreqtype = [strreqtype componentsSeparatedByString:@","];
                
                
                if (![[arrobjFriends objectAtIndex:i] objectForKey:@"isfriend"])
                {
                    _btnAddFriend = (UIButton*)[cell viewWithTag:i+1];
                    [_btnAddFriend setImage:[UIImage imageNamed:@"Friends.png"] forState:UIControlStateNormal];
                }
                else
                {
                    
                    if([strreqstatus isEqualToString:@"requestsent"])
                    {
                        
                        NSLog(@"%@ %@ %@",strreqtype,strUserid,[[arrobjFriends objectAtIndex:i] objectForKey:@"friendid"]);
                        NSLog(@"%@",strfriendid);
                        
                        if ([[objArrreqtype lastObject]isEqualToString:[[arrobjFriends objectAtIndex:i] objectForKey:@"friendid"]])
                        {
                            
                        }
                        if ([[objArrreqtype lastObject] isEqualToString:strUserid]) {
                            
                        }
                        if ([strfriendid isEqualToString:[arrobjFriends lastObject]])
                        {
                            
                        }
                        
                        if ([[objArrreqtype firstObject]isEqualToString:strUserid] && [[objArrreqtype lastObject] isEqualToString:[[arrobjFriends objectAtIndex:i] objectForKey:@"friendid"]])
                        {
                            _btnAddFriend = (UIButton*)[cell viewWithTag:i+1];
                            [_btnAddFriend setImage:[UIImage imageNamed:@"RequestSent.png"] forState:UIControlStateNormal];
                        }
                        else if ([[objArrreqtype lastObject]isEqualToString:[[arrobjFriends objectAtIndex:i] objectForKey:@"friendid"]] && [[objArrreqtype lastObject] isEqualToString:strUserid] && [strUserid isEqualToString:[objArrreqtype lastObject]])
                        {
                            
                            _btnAddFriend = (UIButton*)[cell viewWithTag:i+1];
                            [_btnAddFriend setImage:[UIImage imageNamed:@"Accept.png"] forState:UIControlStateNormal];
                        }
                        else
                        {
                            _btnAddFriend = (UIButton*)[cell viewWithTag:i+1];
                            [_btnAddFriend setImage:[UIImage imageNamed:@"AddFriend.png"] forState:UIControlStateNormal];
                        }
                        
                    }
                    else if([strreqstatus isEqualToString:@"addfriend"])
                    {
                        _btnAddFriend = (UIButton*)[cell viewWithTag:i+1];
                        [_btnAddFriend setImage:[UIImage imageNamed:@"AddFriend.png"] forState:UIControlStateNormal];
                        
                    }
                }
                
                
                
            }
    }
    
    [cell.contentView addSubview:_btnAddFriend];
    
    [_btnAddFriend addTarget:self action:@selector(TableBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
}


-(void)addnewentry:(NSInteger)tag
{
    
        objPF = [aArray objectAtIndex:tag-1];
    
        PFObject *objpf1 = [PFObject objectWithClassName:@"Friends"];
        [objpf1 setObject:strUserid forKey:@"userid"];
        [objpf1 setObject:objPF.objectId forKey:@"friendid"];
        [objpf1 setObject:[objPF valueForKey:@"fullname"] forKey:@"friendname"];
        [objpf1 setObject:[objPF valueForKey:@"status"] forKey:@"friendstatus"];
    
        [objpf1 setObject:[NSNumber numberWithBool:NO] forKey:@"isfriend"];
        [objpf1 setObject:[NSString stringWithFormat:@"%@,%@",strUserid,objPF.objectId] forKey:@"reqtype"];
        [objpf1 setObject:@"requestsent" forKey:@"reqstatus"];
        [objpf1 setObject:[objPF objectForKey:@"profilepic"] forKey:@"friendprofilepic"];

        [objpf1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                [self ReloadTable];
            }
            else
            {
                // There was a problem, check error.description
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



-(void)ReloadTable
{
    PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
    [query1 whereKey:@"userid" equalTo:strUserid];
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Friends"];
    [query2 whereKey:@"friendid" equalTo:strUserid];
    
    PFQuery *query3 = [PFQuery orQueryWithSubqueries:@[query1, query2]];
    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         
         if (!error) {
             arrobjFriends = [[NSArray alloc]initWithArray:objects];
             [_tblViewFriends reloadData];
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}

-(void)TableBtnClicked:(UIButton*)sender
{
    objPF = [aArray objectAtIndex:sender.tag-1];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Friends"];
    [query whereKey:@"userid" equalTo:strUserid];
    [query whereKey:@"friendid" equalTo:objPF.objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         
         if (!error) {
             
             objQueryResult=[objects firstObject];
             
             if (objQueryResult == nil )
             {
                 [self addnewentry:sender.tag];
             }
             else
             {
                 [self updatequery];
             }
             
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
         
         
     }];

}



-(void)updatequery
{
    PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
    [query1 whereKey:@"objectId" equalTo:objQueryResult.objectId];
    
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *userStats, NSError *error) {
        if (!error)
        {
            // Found UserStats
            NSString *temp=[userStats objectForKey:@"reqstatus"];
            
            if ([temp isEqualToString:@"requestsent"])
            {
                [userStats setObject:@"addfriend" forKey:@"reqstatus"];
            }
            if ([temp isEqualToString:@"addfriend"])
            {
                [userStats setObject:@"requestsent" forKey:@"reqstatus"];
            }
            // Save
            [userStats saveInBackground];
            [self ReloadTable];
        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
    }];
}

@end
