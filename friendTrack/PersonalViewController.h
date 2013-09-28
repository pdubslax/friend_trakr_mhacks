//
//  PersonalViewController.h
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastContactLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactbuttonlabel;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *picture;
@property (nonatomic) float percentage;
@property (nonatomic) NSString *lastContact;


@end
