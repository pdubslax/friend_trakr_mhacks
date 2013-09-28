//
//  ViewControllerLogin.m
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "ViewControllerLogin.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
@interface ViewControllerLogin ()

@end

@implementation ViewControllerLogin

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
    
    
     
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                  bundle:nil];
    UITabBarController* vc = [sb instantiateViewControllerWithIdentifier:@"tabBarBaby"];
    vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
     
        
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            NSLog(@"User with facebook logged in!");
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];

}




@end
