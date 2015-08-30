

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "DatePicker.h"

@class CustomRangeDatePicker;

@protocol CustomRangeDatePickerDeleagte <NSObject>
@optional
-(void)rangeDatePickerDismissed:(CustomRangeDatePicker*)singleDatePicker Date:(NSString*)dateString BySingle:(BOOL)single;
-(void)rangeDatePickerChangedDate:(CustomRangeDatePicker*)singleDatePicker Date:(NSString*)dateString;

@end

@interface CustomRangeDatePicker : UIView<DatePickerDeleagte,UIScrollViewDelegate>
{
    DatePicker*datePickerFrom,*datePickerTo;
    NSString *dateStringFrom,*dateStringTo;
}

@property(strong,nonatomic) id<CustomRangeDatePickerDeleagte> delegate;

@end
