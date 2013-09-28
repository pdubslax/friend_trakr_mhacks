//
//  FriendCell.h
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dummyLabel;
@property (nonatomic) float friend_level;


@end
