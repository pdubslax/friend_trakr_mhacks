//
//  AddFriends.h
//  friendTrack
//
//  Created by Patrick Wilson on 9/22/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriends : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *filteredFriendArray;
@end
