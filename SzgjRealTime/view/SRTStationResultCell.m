//
//  SRTStationResultCell.m
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTStationResultCell.h"

@implementation SRTStationResultCell
@synthesize labelStandCode;
@synthesize labelStandName;
@synthesize labelRoad;
@synthesize labelArea;
@synthesize labelBus;
@synthesize labelTrend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // init cell view
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"SRTStationResultCell" owner:self options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                [self setLabelStandName: (UILabel *)[view viewWithTag:21]];
                
                [self setLabelRoad:(UILabel *)[view viewWithTag:22]];
                
                [self setLabelTrend: (UILabel *)[view viewWithTag:23]];
                
                [self setLabelBus: (UILabel *)[view viewWithTag:24]];
                
                [self setLabelStandCode: (UILabel *)[view viewWithTag:25]];

                for (UIView *  v in [view subviews] ) {
                    [self addSubview:v];
                }
                
            }
        }  
        
        UIView *__backView = [[[UIView alloc]initWithFrame:CGRectZero] autorelease];
        [__backView setBackgroundColor:[UIColor whiteColor]];
        self.backgroundView = __backView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [labelStandCode release];
    [labelStandName release];
    [labelBus release];
    [labelRoad release];
    [labelArea release];
    [labelTrend release];
    
    [super dealloc];
}
@end
