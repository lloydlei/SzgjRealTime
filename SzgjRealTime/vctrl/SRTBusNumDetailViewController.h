//
//  SRTTrainNumDetailViewController.h
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRTBusLine.h"

@interface SRTBusNumDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *busNumDetailTableView;

@property (assign,nonatomic )BOOL cellNibRegisted;

@property (retain, nonatomic) NSArray *lineNumDetail;

@property (copy ,nonatomic) NSString  *lineGuid;

@property (assign ,nonatomic) BOOL fromStationDetail;

@property (strong ,nonatomic) UIActivityIndicatorView * activityIndicator;

@property (strong ,nonatomic) UIView *opaqueView;

@property (retain , nonatomic) SRTBusLine * busLine;


- (void) querySingleLine;

- (void) addFavorite;

- (void) refresh;
@end
