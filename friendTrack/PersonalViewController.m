//
//  PersonalViewController.m
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "PersonalViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonalViewController ()

@end

@implementation PersonalViewController

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
    self.nameLabel.text = self.name;
    [self.imageLabel setImage:self.picture];
    self.progressLabel.progress = self.percentage;
    self.lastContactLabel.text = @"";
    [self.contactbuttonlabel setTitle:[NSString stringWithFormat:@"Contact %@",self.name] forState:UIControlStateNormal];
    
    CALayer * bing = [self.imageLabel layer];
    [bing setMasksToBounds:YES];
    [bing setCornerRadius:10.0];
    
    if (self.percentage>.5) {
        self.progressLabel.progressTintColor = [UIColor greenColor];
    }
    else{
        self.progressLabel.progressTintColor = [UIColor redColor];
    }
    self.title = @"     Friendship Summary";


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
