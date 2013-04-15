//
//  SRTBusNumDetailCell.m
//  SzgjRealTime
//
//  Created by user on 13-4-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTBusNumDetailCell.h"

@implementation SRTBusNumDetailCell
@synthesize labelStandCode;
@synthesize labelEnterStationName;
@synthesize labelStationName;
@synthesize labelEnterTime;
@synthesize curImage;
@synthesize currentTopImage;
@synthesize currentBottomImage ;
@synthesize labelPreTime;
@synthesize isCur;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"SRTBusNumDetailCell" owner:self options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                
                
                [self setCurImage: (UIImageView *)[view viewWithTag:31]];
                
                [self setCurrentTopImage: (UIImageView *)[view viewWithTag:32]];
                [self setCurrentBottomImage: (UIImageView *)[view viewWithTag:33]];
                
                [self setLabelEnterStationName: (UILabel *)[view viewWithTag:34]];
                
                [self setLabelStationName:(UILabel *)[view viewWithTag:35]];
                
                [self setLabelEnterTime: (UILabel *)[view viewWithTag:36]];
                
                [self setLabelStandCode: (UILabel *)[view viewWithTag:37]];
                
                [self setLabelPreTime: (UILabel *)[view viewWithTag:38]];
                
                for (UIView *  v in [view subviews] ) {
                    [self addSubview:v];
                }
                
            }
        }  

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [labelStationName release];
    [labelStandCode release];
    [labelEnterTime release];
    [labelEnterStationName release];
    [labelPreTime release];
    [currentTopImage release];
    [currentBottomImage release];
    [curImage release];
    [super dealloc];
}
@end
