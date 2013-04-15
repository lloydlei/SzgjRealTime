//
//  SRTStationDetailViewController.h
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRTStation.h"

@interface SRTStationDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *stationDetailTableView;
@property (copy,nonatomic) NSString * standCode;
@property (retain,nonatomic) NSArray * stationDetailInfos;
@property (assign ,nonatomic) BOOL fromFavor;
@property (strong ,nonatomic) UIActivityIndicatorView * activityIndicator;

@property (strong ,nonatomic) UIView *opaqueView;

@property (retain,nonatomic) SRTStation *station;
- (void) queryStationBus;

- (void) addFavorite;

- (void) refresh;
@end
