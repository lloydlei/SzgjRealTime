//
//  SRTCacheHelper.m
//  SzgjRealTime
//
//  Created by user on 13-4-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTCacheHelper.h"



@implementation SRTCacheHelper
+ (void ) cacheJKArray:(NSArray *) jkArray forKey:(NSString * )key{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    //NSDictionary *dic = [NSDictionary dictionaryWithObject:jkArray forKey:key];
    [ud setObject:jkArray forKey: key];
    //printf("cacheBusLineSearchReaultJSON: \n %s \n ",[[jkArray description] cStringUsingEncoding:NSUTF8StringEncoding]);
    [ud synchronize];
}

+ (NSArray *) getJKArrayForKey:(NSString * )key{
    NSArray * array = [[NSUserDefaults standardUserDefaults]  arrayForKey:key ];  
    printf("getBusLineSearchReaultJSON: \n %s \n ",[[array description] cStringUsingEncoding:NSUTF8StringEncoding]);                    
    return array;
}




@end
