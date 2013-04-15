//
//  SRTBusLine.m
//  SzgjRealTime
//
//  Created by user on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTBusLine.h"

@implementation SRTBusLine
@synthesize lineNumber;
@synthesize runTime;
@synthesize startStation;
@synthesize endStation;
@synthesize lineGuid;
@synthesize totalStation;

/* This code has been added to support encoding and decoding my objects */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.lineNumber forKey:@"lineNumber"];
    [encoder encodeObject:self.runTime forKey:@"runTime"];
    [encoder encodeObject:self.startStation forKey:@"startStation"];
    [encoder encodeObject:self.endStation forKey:@"endStation"];
    [encoder encodeObject:self.lineGuid forKey:@"lineGuid"];
    [encoder encodeInt:self.totalStation forKey:@"totalStation"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if ( (self =[super init]))
    {
        //decode the properties
        //NSLog(@"DECODER decoderObjectForKey;lineNumber=%@",[decoder decodeObjectForKey:@"lineNumber"]);
        self.lineNumber = [decoder decodeObjectForKey:@"lineNumber"];
        self.runTime = [decoder decodeObjectForKey:@"runTime"];
        self.startStation = [decoder decodeObjectForKey:@"startStation"];
        self.endStation = [decoder decodeObjectForKey:@"endStation"];
        self.lineGuid = [decoder decodeObjectForKey:@"lineGuid"];
        self.totalStation = [decoder decodeIntForKey:@"totalStation"];

        
        
    }
    return self;
}

-(NSString*)description {
    return [[[NSString alloc]initWithFormat:@"lineGuid:%@ lineNumber:%@ startStation:%@ endStation:%@ runTime:%@", self.lineGuid, self.lineNumber,self.startStation,self.endStation,self.runTime ]autorelease];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    SRTBusLine *copy = [[SRTBusLine allocWithZone:zone] init];
    copy.lineGuid = [[self.lineGuid copy] autorelease];
    copy.lineNumber = [[self.lineNumber copy] autorelease];
    copy.runTime = [[self.runTime copy] autorelease];
    copy.startStation = [[self.startStation copy] autorelease];
    copy.endStation = [[self.endStation copy] autorelease];
    copy.totalStation = self.totalStation;
    //copy.boolValue = self.boolValue;
    return copy;
}

@end
