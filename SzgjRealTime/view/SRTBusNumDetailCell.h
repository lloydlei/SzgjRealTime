//
//  SRTBusNumDetailCell.h
//  SzgjRealTime
//
//  Created by user on 13-4-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTBusNumDetailCell : UITableViewCell

@property (retain,nonatomic) UILabel * labelStandCode;
@property (retain,nonatomic) UILabel * labelStationName;
@property (retain,nonatomic) UILabel * labelEnterStationName;
@property (retain,nonatomic) UILabel * labelEnterTime;
@property (retain,nonatomic) UIImageView * curImage;
@property (retain,nonatomic) UIImageView * currentTopImage;
@property (retain,nonatomic) UIImageView * currentBottomImage;
@property (retain,nonatomic) UILabel * labelPreTime;
@property (assign,nonatomic) BOOL isCur;
@end
