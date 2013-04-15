//
//  SRTHttpHelper.m
//  SzgjRealTime
//
//  Created by user on 13-4-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTHttpHelper.h"
#import "SRTNetworkHelper.h"

@implementation SRTHttpHelper
+(NSArray *)getJSONData:(NSString *)nonEncodedurl{
    NSString *encodedUrl = [nonEncodedurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];    
    if ([SRTNetworkHelper getNetWorkState] ) {
        NSURL *url=[NSURL URLWithString:encodedUrl];  
        NSLog(@"URL=%@",url);
        NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0];         
        NSError *err=nil;      
        NSData *jsonData=[NSURLConnection sendSynchronousRequest:request  
                                               returningResponse:nil  
                                                           error:&err];  
        NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
        if (resultsDictionary && [ [NSString stringWithFormat:@"%@",[resultsDictionary objectForKey:@"resultCode" ]] isEqualToString:@"0"]) {
            NSLog(@"getJSONData=%@", [resultsDictionary objectForKey:@"data"]);
            
            return [resultsDictionary objectForKey:@"data"];

        }
    }   
    
    return [[[NSArray alloc] init ] autorelease];
}
@end
