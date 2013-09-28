//
//  FriendCell.m
//  friendTrack
//
//  Created by Patrick Wilson on 9/21/13.
//  Copyright (c) 2013 Patrick Wilson. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

@synthesize nameLabel,progressLabel,imageLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
