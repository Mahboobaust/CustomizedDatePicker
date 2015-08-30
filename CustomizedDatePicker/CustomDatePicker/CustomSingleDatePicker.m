
#import "CustomSingleDatePicker.h"

@interface CustomSingleDatePicker ()

@end

@implementation CustomSingleDatePicker

-(void)drawRect:(CGRect)rect{
    
    _dateString=@"";
    
    self.backgroundColor=[UIColor whiteColor];
    
    NSMutableDictionary *properties=[[NSMutableDictionary alloc]init];
     [properties setValue:UIColorFromRGB(0xffffff) forKey:DatePickerBackgroundColor];
    [properties setValue:@(69.0) forKey:DatePickerTableWidth];
    [properties setValue:@(1.0) forKey:DatePickerTableInterGap];
    [properties setValue:@(44.0) forKey:DatePickerTableRowHeight];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:15.0] forKey:DatePickerTableFontNormal];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:17.0] forKey:DatePickerTableFontSelected];
    [properties setValue:UIColorFromRGB(0X097878) forKey:DatePickerTableFontColorNormal];
    [properties setValue:UIColorFromRGB(0XA0000C) forKey:DatePickerTableFontColorSelected];

 
    datePicker=[[DatePicker alloc]initWithFrame:CGRectMake(0, 36, self.frame.size.width, 140) Properties:properties];
    datePicker.delegate=self;
    [self addSubview:datePicker];
    [self createDividers];
}


-(void)datePickerChangedDate:(DatePicker*)datePicker Date:(NSString*)dateString
{
    _dateString=dateString?:@"";
    
    if([self.delegate respondsToSelector:@selector(singleDatePickerChangedDate:Date:)])
        [self.delegate singleDatePickerChangedDate:self Date:_dateString];
}

-(IBAction)btnDoneAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(singleDatePickerDismissed:Date:ByRange:)])
        [self.delegate singleDatePickerDismissed:self Date:_dateString ByRange:NO];
}

-(IBAction)btnRangeAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(singleDatePickerDismissed:Date:ByRange:)])
        [self.delegate singleDatePickerDismissed:self Date:_dateString ByRange:YES];
    
}


-(void)createDividers{
  int  XPOS=15, YPOS=80, Height=2, Width=45, GAP=25;
    
    UIView*topDivier,*bottomDivier;
    
    for(int i=0;i<3;i++){
        XPOS=i==0?XPOS: GAP+XPOS+Width;
        topDivier=[[UIView alloc]initWithFrame:CGRectMake(XPOS, YPOS, Width, Height)];
        topDivier.backgroundColor=UIColorFromRGB(0X785A5A);
        [self addSubview:topDivier];
        
        bottomDivier=[[UIView alloc]initWithFrame:CGRectMake(XPOS,topDivier.frame.origin.y+44, Width, Height)];
        bottomDivier.backgroundColor=UIColorFromRGB(0X785A5A);
        [self addSubview:bottomDivier];
    }

}





@end
