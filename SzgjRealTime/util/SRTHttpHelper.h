//
//  SRTHttpHelper.h
//  SzgjRealTime
//
//  Created by user on 13-4-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kSRTHttpBusLineSearchUrl @"http://42.121.117.61:6068/bustime/api/queryLine"
#define kSRTHttpBusLineDetailUrl @"http://42.121.117.61:6068/bustime/api/querySingleLine"
#define kSRTHttpBusLineUpdateUrl @"http://42.121.117.61:6068/bustime/api/queryRunSingleLine"
#define kSRTHttpStationSearchUrl @"http://42.121.117.61:6068/bustime/api/queryStation"
#define kSRTHttpStationBusUrl    @"http://42.121.117.61:6068/bustime/api/queryStationBus"


@interface SRTHttpHelper : NSObject

+(NSArray *) getJSONData:(NSString *)url;

@end
