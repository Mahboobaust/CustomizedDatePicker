//
//  Utilities.m
//  CustomizedDatePicker
//
//  Created by Mahboob on 8/30/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities


+(NSDate*)DateTimeFromString:(NSString*)timeString Format:(NSString*)format UTC:(BOOL)UTC{
    
    NSDate *dateFromString;
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        
        if(UTC){
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        }
        
        dateFromString = [dateFormatter dateFromString:timeString];
    }
    @catch (NSException *exception) {
        dateFromString=nil;
    }
    @finally {
        return dateFromString;
    }
    
}

+(NSString*)StringFromDate:(NSDate*)date Format:(NSString*)format Local:(BOOL)local{
    
    NSString *dateString=@"";
    
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        
        if(!local){
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        }
        
        dateString = [dateFormatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        dateString=@"";
    }
    @finally {
        return dateString;
    }
    
}


+(BOOL)stringIsNil:(NSString*)string{
    NSString *nullString;
    if(string==nullString || [string isEqual:[NSNull null]] || [string isEqualToString:@""]){
        return YES;
    }
    return NO;
}


@end
