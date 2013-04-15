//
//  SRTAppHelper.m
//
//  Created by leilei on 12-05-20.
//  Copyright (c) 2012年 snda. All rights reserved.
//


#import "SRTAppHelper.h"

@implementation SRTAppHelper
+ (SRTAppDelegate *) curAppDelegate{
    return (SRTAppDelegate *)[[UIApplication sharedApplication] delegate];
}



+(void) alertMsg:(NSString *)message{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"信息小贴士" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
}
@end
