//
//  SRTNetworkHelper.m
//  SzgjRealTime
//
//  Created by user on 13-4-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTNetworkHelper.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@implementation SRTNetworkHelper

+ (bool)getNetWorkState
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // 以下objc相关函数、类型需要添加System Configuration 框架
    // 用0.0.0.0来判断本机网络状态
    /**
     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
     *
     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
     *  第一个参数可以为NULL或kCFAllocatorDefault
     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
     *  同时返回一个引用必须在用完后释放.
     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
     *  第二个参数比如为"www.apple.com",其他和上一个一样.
     *
     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
     *  第一个参数为之前建立的测试连接的引用,
     *  第二个参数用来保存获得的状态,
     *  如果能获得状态则返回TRUE，否则返回FALSE
     *
     */
    SCNetworkReachabilityRef defaultRouteReachability
    = SCNetworkReachabilityCreateWithAddress(NULL,(struct sockaddr*)&zeroAddress);
    
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability,&flags);
    
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return false;
    }
    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? true : false;
    //    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    //    NSString *strURL = [[NSString alloc] initWithCString:UrlStr encoding:NSUTF8StringEncoding];
    //    NSURL *testURL = [NSURL URLWithString:strURL];
    //    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    //    [strURL release];
    //    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
    //    // 真机nonWiFi，模拟器！nonWiFi
    //    if( ((isReachable && (!needsConnection)) || nonWiFi) ? (testConnection ? YES : NO) : NO )
    //    {
    //        return true;
    //    }
    //    else
    //    {
    //        return false;
    //    }
}

@end
