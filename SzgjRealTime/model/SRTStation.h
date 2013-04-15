//
//  SRTStation.h
//  SzgjRealTime
//
//  Created by user on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTStation : NSObject<NSCoding>
@property (nonatomic,retain) NSString *standCode;
@property (nonatomic,retain) NSString *standName;
@property (nonatomic,retain) NSString *road;
@property (nonatomic,retain) NSString *area;
@property (nonatomic,retain) NSString *bus;
@property (nonatomic,retain) NSString *trend;

-(void)encodeWithCoder:(NSCoder *)encoder;
-(id)initWithCoder:(NSCoder *)decoder;
@end
