//
//  FriendsViewController.h
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "ViewController.h"

@interface FriendsViewController : ViewController <UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)editButton:(id)sender;
- (IBAction)logout:(id)sender;
extern NSMutableArray *tableData;
extern    NSMutableArray *picData;
extern    NSMutableArray  *friendData;
extern    NSMutableArray *lastContact;
extern int myID;
@property (assign, nonatomic) BOOL ascending;


@end
