//
//  CustomizedDatePickerViewController.h
//  CustomizedDatePicker
//
//  Created by Mahboob on 8/30/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSingleDatePicker.h"
#import "CustomRangeDatePicker.h"
#import "objc/message.h"
@interface CustomizedDatePickerViewController : UIViewController<CustomDatePickerDeleagte,CustomRangeDatePickerDeleagte>
{
    CustomSingleDatePicker *customSingleDatePicker;
    CustomRangeDatePicker  *customRangeDatePicker;
    BOOL isSingle, isRange;
}

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnRange;
@property (strong, nonatomic) IBOutlet UIButton *btnSingle;

@end
