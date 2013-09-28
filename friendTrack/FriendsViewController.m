//
//  FriendsViewController.m
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PersonalViewController.h"
#import <Parse/Parse.h>

@interface FriendsViewController ()

@end



@implementation FriendsViewController{
    
}

NSMutableArray *tableData;
NSMutableArray *picData;
NSMutableArray  *friendData;
NSMutableArray *lastContact;
int myID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Now add the data to the UI elements
    // ...


    /*tableData = [[NSMutableArray alloc] init];
    picData = [NSMutableArray arrayWithObjects:@"pic2.jpg",@"pic6.jpg",@"pic4.jpg",@"pic5.jpg",@"pic3.jpg", nil];
    srand(time(NULL));
    friendData = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:(float)rand()/RAND_MAX],[NSNumber numberWithFloat:(float)rand()/RAND_MAX],[NSNumber numberWithFloat:(float)rand()/RAND_MAX],
                  [NSNumber numberWithFloat:(float)rand()/RAND_MAX],[NSNumber numberWithFloat:(float)rand()/RAND_MAX], nil];
     */
    //lastContact = [[NSMutableArray alloc]init];
    //lastContact = [NSMutableArray arrayWithObjects:@"Last Contacted: 1 Month Ago",@"Last Contacted: 2 Weeks Ago",@"Last Contacted: 1 Year Ago",@"Last Contacted: 5 Days Ago",@"Last Contacted: 3 Years Ago", nil];
    lastContact = [[NSMutableArray alloc]init];
    
    picData = [[NSMutableArray alloc]init];
    
    tableData = [[NSMutableArray alloc]init];
    
    friendData = [[NSMutableArray alloc]init];
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    
    
    // Send request to Facebook
    
            
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [picData count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    static NSString *reuseIdentifier = @"nothing";
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"customTableViewCellTest1" owner:self options:nil] objectAtIndex:0];
    }
    
    //set cell properties
    
    cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
    [cell.imageLabel setImage:[picData objectAtIndex:indexPath.row]];
    cell.dummyLabel.text=@"";
    //cell.dummyLabel.text = [lastContact objectAtIndex:indexPath.row];
    [cell.progressLabel setProgress:[[friendData objectAtIndex:indexPath.row]floatValue]];
    
    if ([[friendData objectAtIndex:indexPath.row] floatValue]>.5) {
        cell.progressLabel.progressTintColor = [UIColor greenColor];
    }
    else{
        cell.progressLabel.progressTintColor = [UIColor redColor];
    }
    
    CALayer * bing = [cell.imageLabel layer];
    [bing setMasksToBounds:YES];
    [bing setCornerRadius:10.0];
    
    
    
   
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                  bundle:nil];
    PersonalViewController* vc = [sb instantiateViewControllerWithIdentifier:@"ExampleViewController2"];
    vc.name = [tableData objectAtIndex:indexPath.row];
    vc.picture = [picData objectAtIndex:indexPath.row];
    vc.percentage = [[friendData objectAtIndex:indexPath.row] floatValue];
    vc.lastContact = @"";
    //vc.lastContact = [lastContact objectAtIndex:indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)editButton:(id)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                  bundle:nil];
    UITabBarController* vc = [sb instantiateViewControllerWithIdentifier:@"addFriends"];
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    vc.hidesBottomBarWhenPushed = YES;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut]; // Log out
    
    //[PFFacebookUtils unlinkUserInBackground:[PFUser currentUser]];
    
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                  bundle:nil];
    UITabBarController* vc = [sb instantiateViewControllerWithIdentifier:@"logscrn"];
    vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [tableData removeAllObjects];
    [picData removeAllObjects];
    [friendData removeAllObjects];
    [lastContact removeAllObjects];
    
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSDictionary *addUser = @{
                                      @"fb_id" : [NSNumber numberWithInt:[facebookID intValue]]
                                      };
            
            
            myID = [facebookID intValue];
            
            NSDictionary *getTuples = @{
                                        @"user_id" : [NSNumber numberWithInt:myID]
                                        };
            [PFCloud callFunctionInBackground:@"getTuples"
                               withParameters:getTuples
                                        block:^(NSArray* result,NSError *error) {
                                            if (!error) {
                                                for (PFObject *bing in result) {
                                                    NSString *tmp = [[bing objectForKey:@"friend_id"]stringValue];
                                                    NSLog([NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", tmp]);
                                                    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", tmp]];
                                                    NSData *data = [NSData dataWithContentsOfURL:pictureURL];
                                                    UIImage *img = [[UIImage alloc] initWithData:data];
                                                    [picData addObject:img];
                                                    
                                                    NSURL *nameURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@?fields=name", tmp]];
                                                    NSData *asssss = [NSData dataWithContentsOfURL:nameURL];
                                                    id jsonObjects = [NSJSONSerialization JSONObjectWithData:asssss options:NSJSONReadingMutableContainers error:nil];
                                                    NSString *nameswag = [jsonObjects objectForKey:@"name"];
                                                    
                                                    [tableData addObject:nameswag];
                                                    
                                                    NSString* tmp_per = [[bing objectForKey:@"friend_percent"]stringValue];
                                                    float umm = [tmp_per floatValue];
                                                    umm /=100;
                                                    [friendData addObject:[NSNumber numberWithFloat:umm]];
                                                }
                                                [self.tableView reloadData];
                                            }
                                            else{
                                                
                                            }
                                            
                                            
                                        }];
            
            [PFCloud callFunctionInBackground:@"userExists"
                               withParameters:addUser
                                        block:^(NSNumber* result,NSError *error) {
                                            if (!error) {
                                                int existing = [result intValue];
                                                if (existing==0) {
                                                    //needs to add user
                                                    [PFCloud callFunction:@"addUser" withParameters:addUser];
                                                    
                                                }else{
                                                    //already exists
                                                    
                                                }
                                            }
                                            else{
                                                
                                            }
                                            
                                            
                                        }];
            // Now add the data to the UI elements
            // ...
        }
    }];
    

    
}


@end
