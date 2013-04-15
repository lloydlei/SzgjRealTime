//
//  SRTFavoriteHelper.h
//  SzgjRealTime
//
//  Created by user on 13-4-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRTBusLine.h"
#import "SRTStation.h"
#import "CustomObject.h"
@interface SRTFavoriteHelper : NSObject

+ (void)saveLineFavorToFile:(SRTBusLine *)line;

+ (void)saveStationFavorToFile:(SRTStation *)station;

+ (NSArray *) getLineFavorFromFile ;

+ (NSArray *) getStationFavorFromFile;

+ (void)saveLineFavorToNSUserDefaults:(SRTBusLine *)line;

+ (void)saveStationFavorToNSUserDefaults:(SRTStation *)station;

+ (NSArray *) getLineFavorFromNSUserDefaults ;

+ (NSArray *) getStationFavorFromNSUserDefaults;

+ (void)saveCustomeObject:(CustomObject *)c;
+ (NSArray *) getCustomerObject;
@end
