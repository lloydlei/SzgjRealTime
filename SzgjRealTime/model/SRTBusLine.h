//
//  SRTBusLine.h
//  SzgjRealTime
//
//  Created by user on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTBusLine : NSObject<NSCoding,NSCopying>
{
    
    NSString * mLineNumber;
    NSString * mRunTime;
    NSString * mStartStation;
    NSString * mEndStation;
    NSString * mLineGuid;
   int mTotalStation;
}
@property (nonatomic,retain) NSString * lineNumber;
@property (nonatomic,retain) NSString * runTime;
@property (nonatomic,retain) NSString * startStation;
@property (nonatomic,retain) NSString * endStation;
@property (nonatomic,retain) NSString * lineGuid;
@property (nonatomic,assign) int totalStation;

-(void)encodeWithCoder:(NSCoder *)encoder;
-(id)initWithCoder:(NSCoder *)decoder;
@end
