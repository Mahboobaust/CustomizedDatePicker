

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "Define.h"
#define MONTHS @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"]
#define MAX_DAY_OF_MONTH @[@(31),@(0),@(31),@(30),@(31),@(30),@(31),@(31),@(30),@(31),@(30),@(31)]

#define YEARS @[@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025"]
#define MAX_DAY_OF_FEB @[@(28),@(28),@(28),@(29),@(28),@(28),@(28),@(29),@(28),@(28),@(28),@(29),@(28)]

static NSString* DatePickerBackgroundColor =@"BackgroundColor";
static NSString* DatePickerTableWidth =@"TableWidth";
static NSString* DatePickerTableInterGap =@"TableInterGap";
static NSString* DatePickerTableRowHeight =@"TableRowHeight";
static NSString* DatePickerTableFontSelected =@"TableFontSelected";
static NSString* DatePickerTableFontNormal =@"TableFontNormal";
static NSString* DatePickerTableFontColorSelected =@"TableFontColorSelected";
static NSString* DatePickerTableFontColorNormal =@"TableFontColorNormal";


@class DatePicker;

@protocol DatePickerDeleagte <NSObject>

@optional
//-(void)datePickerDismissed:(DatePicker*)datePicker Date:(NSString*)dateString;
-(void)datePickerChangedDate:(DatePicker*)datePicker Date:(NSString*)dateString;

@end


@interface DatePicker : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView*dayTableView,*monthsTableView,*yearsTableView;
    UITableViewCell *cell;
    
    NSMutableArray*daysArray,*monthsArray,*yearsArray;
    NSRange dayRange;
    
    
    int repeatCounts;
    unsigned long selectedDay,selectedMonth,selectedYear; //  Array's Selected Index (1 Based)
    
    unsigned long dayIndexFullLength,monthIndexFullLength,yearIndexFullLength;
    
    float tableWidth,tableInterGap,rowHeight;
    UIFont* fontNormal, *fontSelected;
    UIColor *colorNormal,*colorSelected;
    
}

@property UIFont *selecttedTextFont;
-(id)initWithFrame:(CGRect)frame Properties:(NSDictionary*)properties;

@property(strong,nonatomic) id<DatePickerDeleagte> delegate;


@end
