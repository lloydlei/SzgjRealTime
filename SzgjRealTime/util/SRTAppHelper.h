//
//  SRTAppHelper.h
//
//  Created by leilei on 12-05-20.
//  Copyright (c) 2012年 snda. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SRTAppDelegate.h"
@interface SRTAppHelper : NSObject
+ (SRTAppDelegate *) curAppDelegate;

+ (void) alertMsg:(NSString *) message;
@end
