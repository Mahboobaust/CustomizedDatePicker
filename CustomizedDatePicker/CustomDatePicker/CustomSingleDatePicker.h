

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "DatePicker.h"


@class CustomSingleDatePicker;

@protocol CustomDatePickerDeleagte <NSObject>

@optional
-(void)singleDatePickerDismissed:(CustomSingleDatePicker*)singleDatePicker Date:(NSString*)dateString ByRange:(BOOL)range;
-(void)singleDatePickerChangedDate:(CustomSingleDatePicker*)singleDatePicker Date:(NSString*)dateString;

@end

@interface CustomSingleDatePicker : UIView<UIScrollViewDelegate,DatePickerDeleagte>
{
    DatePicker*datePicker;
    NSString*_dateString;
}

@property(strong,nonatomic) id<CustomDatePickerDeleagte> delegate;

@end
