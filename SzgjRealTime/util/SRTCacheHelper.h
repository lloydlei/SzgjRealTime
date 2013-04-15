//
//  SRTCacheHelper.h
//  SzgjRealTime
//
//  Created by user on 13-4-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRTResourcesHelper.h"
#import "SRTBusLine.h"
#import "SRTStation.h"

@interface SRTCacheHelper : NSObject

+ (void ) cacheJKArray:(NSArray *) jkArray forKey:(NSString * )key;

+ (NSArray *) getJKArrayForKey:(NSString * )key;

@end
