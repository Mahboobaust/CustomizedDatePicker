//
//  Utilities.h
//  CustomizedDatePicker
//
//  Created by Mahboob on 8/30/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSString*)StringFromDate:(NSDate*)date Format:(NSString*)format Local:(BOOL)local;
+(NSDate*)DateTimeFromString:(NSString*)timeString Format:(NSString*)format UTC:(BOOL)UTC;
+(BOOL)stringIsNil:(NSString*)string;
@end
