//
//  AddFriends.m
//  friendTrack
//
//  Created by Patrick Wilson on 9/22/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "AddFriends.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "FriendCell.h"
#import <QuartzCore/QuartzCore.h>


@interface AddFriends ()

@end

@implementation AddFriends

NSMutableArray *tableData;
NSMutableArray *picData;
NSMutableArray  *friendData;
NSMutableArray *lastContact;
NSMutableArray *test,*idarray;
int myID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Issue a Facebook Graph API request to get your user's friend list
    self.title=@"Add Friends";
    
    
    test=[[NSMutableArray alloc] init];
    idarray=[[NSMutableArray alloc] init];
    
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        //NSArray* pictures = [result objectForKey:@"picture"];
        NSLog(@"Found: %i friends", friends.count);
        int i=0;
        for (NSDictionary<FBGraphUser>* friend in friends) {
            
            
              [test addObject:friend.name];
            [idarray addObject:friend.id];
            i++;
        }
        
        NSArray *first = [test copy];
        NSArray *second = [idarray copy];
        NSMutableArray *p = [NSMutableArray arrayWithCapacity:first.count];
        for (NSUInteger i = 0 ; i != first.count ; i++) {
            [p addObject:[NSNumber numberWithInteger:i]];
        }
        [p sortWithOptions:0 usingComparator:^NSComparisonResult(id obj1, id obj2) {
            // Modify this to use [first objectAtIndex:[obj1 intValue]].name property
            NSString *lhs = [first objectAtIndex:[obj1 intValue]];
            // Same goes for the next line: use the name
            NSString *rhs = [first objectAtIndex:[obj2 intValue]];
            return [lhs compare:rhs];
        }];
        NSMutableArray *sortedFirst = [NSMutableArray arrayWithCapacity:first.count];
        NSMutableArray *sortedSecond = [NSMutableArray arrayWithCapacity:first.count];
        [p enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSUInteger pos = [obj intValue];
            [sortedFirst addObject:[first objectAtIndex:pos]];
            [sortedSecond addObject:[second objectAtIndex:pos]];
        }];
        test=[sortedFirst copy];
        idarray=[sortedSecond copy];
        /*
        NSMutableArray *heyThere = [test sortedArrayUsingSelector:
                       @selector(localizedCaseInsensitiveCompare:)];
        test = [heyThere copy];
        */

        [self.tableView reloadData];
        //NSLog(@"%@", test);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *reuseIdentifier = @"nothing";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [test objectAtIndex:indexPath.row];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
    
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    long long addID = [[idarray objectAtIndex:indexPath.row] longLongValue];
    
    NSDictionary *addFriend = @{
                              @"friend_id" : [NSNumber numberWithLongLong:addID],
                              @"user_id" : [NSNumber numberWithInt:myID],
                              @"friend_percent" : [NSNumber numberWithInt:100],
                              @"friend_is_user" : [NSNumber numberWithInt:0],
                              @"last_contact" : [NSDate date]
                              };
    
    [PFCloud callFunctionInBackground:@"addTuple" withParameters:addFriend block:^(id result,NSError *error) {
        if (!error){
            
                
            UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                          bundle:nil];
            UITabBarController* vc = [sb instantiateViewControllerWithIdentifier:@"woohooboiz"];
            vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
            [vc viewDidLoad];
            
            [self.navigationController popViewControllerAnimated:YES];
            }
        else{
            
        }
        
        
    }];
    
    
    
    
    
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [test count];
}



@end
