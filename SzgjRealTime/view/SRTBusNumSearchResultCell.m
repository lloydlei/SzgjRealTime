//
//  SRTBusNumSearchResultCell.m
//  SzgjRealTime
//
//  Created by user on 13-4-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTBusNumSearchResultCell.h"

@implementation SRTBusNumSearchResultCell
@synthesize labelLineNumber;
@synthesize labelRunTime;
@synthesize labelStartStation;
@synthesize labelEndStation;
@synthesize labelLineGuid;
@synthesize labelTotalStation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // init cell view
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"SRTBusNumSearchResultCell" owner:self options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                [self setLabelLineNumber: (UILabel *)[view viewWithTag:11]];
                
                [self setLabelRunTime:(UILabel *)[view viewWithTag:12]];
                
                [self setLabelStartStation: (UILabel *)[view viewWithTag:13]];
                
                [self setLabelEndStation: (UILabel *)[view viewWithTag:14]];
                
                [self setLabelLineGuid: (UILabel *)[view viewWithTag:15]];
                
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
    [labelLineNumber release];
    [labelRunTime release];
    [labelStartStation release];
    [labelEndStation release];
    [labelLineGuid release];
    [labelTotalStation release];
    [super dealloc];
}
@end
