//
//  SRTStationDetailCell.m
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTStationDetailCell.h"

@implementation SRTStationDetailCell
@synthesize labelEndStation;
@synthesize labelLineGuid;
@synthesize labelLineNumber;
@synthesize labelStandNum;
@synthesize labelStartStation;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // init cell view
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"SRTStationDetailCell" owner:self options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                [self setLabelLineNumber: (UILabel *)[view viewWithTag:41]];
                
                [self setLabelStandNum:(UILabel *)[view viewWithTag:42]];
                
                [self setLabelStartStation: (UILabel *)[view viewWithTag:43]];
                
                [self setLabelEndStation: (UILabel *)[view viewWithTag:44]];
                
                [self setLabelLineGuid: (UILabel *)[view viewWithTag:45]];
                
                for (UIView *  v in [view subviews] ) {
                    [self addSubview:v];
                }
                
            }
        }
        //[self setAlpha:0];
        [self setBackgroundColor: [UIColor yellowColor]];
    }
    return self;
}

- (void)dealloc {
    [labelStartStation release];
    [labelEndStation release];
    [labelStandNum release];
    [labelLineNumber release];
    [labelLineGuid release];
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
