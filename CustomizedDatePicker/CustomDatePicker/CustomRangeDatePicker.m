
#import "CustomRangeDatePicker.h"


@interface CustomRangeDatePicker ()

@end

@implementation CustomRangeDatePicker

-(void)drawRect:(CGRect)rect{
    
    dateStringFrom=@"";
    dateStringTo=@"";
    
    self.backgroundColor=[UIColor whiteColor];
    
    NSMutableDictionary *properties=[[NSMutableDictionary alloc]init];
    [properties setValue:UIColorFromRGB(0xffffff) forKey:DatePickerBackgroundColor];
    [properties setValue:@(69.0) forKey:DatePickerTableWidth];
    [properties setValue:@(-4.0) forKey:DatePickerTableInterGap];
    [properties setValue:@(44.0) forKey:DatePickerTableRowHeight];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:15.0] forKey:DatePickerTableFontNormal];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:17.0] forKey:DatePickerTableFontSelected];
    [properties setValue:UIColorFromRGB(0X097878) forKey:DatePickerTableFontColorNormal];
    [properties setValue:UIColorFromRGB(0XA0000C) forKey:DatePickerTableFontColorSelected];
    
    datePickerFrom=[[DatePicker alloc]initWithFrame:CGRectMake(0, 36, self.frame.size.width/2, 140) Properties:properties];
    datePickerFrom.delegate=self;
    [self addSubview:datePickerFrom];
    
    
    
    properties=[[NSMutableDictionary alloc]init];
    [properties setValue:UIColorFromRGB(0xffffff) forKey:DatePickerBackgroundColor];
    [properties setValue:@(69.0) forKey:DatePickerTableWidth];
    [properties setValue:@(-4.0) forKey:DatePickerTableInterGap];
    [properties setValue:@(44.0) forKey:DatePickerTableRowHeight];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:15.0] forKey:DatePickerTableFontNormal];
    [properties setValue:[UIFont fontWithName:@"HelveticaNeue" size:17.0] forKey:DatePickerTableFontSelected];
    [properties setValue:UIColorFromRGB(0X097878) forKey:DatePickerTableFontColorNormal];
    [properties setValue:UIColorFromRGB(0XA0000C) forKey:DatePickerTableFontColorSelected];
    
    
    datePickerTo=[[DatePicker alloc]initWithFrame:CGRectMake(self.frame.size.width/2+1, 36, self.frame.size.width/2-1, 140) Properties:properties];
    datePickerTo.delegate=self;
    [self addSubview:datePickerTo];


    
    [self createDividers];
}

-(void)datePickerChangedDate:(DatePicker*)datePicker Date:(NSString*)dateString
{
    if([datePicker isEqual:datePickerFrom]){
        dateStringFrom=dateString?:@"";
    }
    else{
        dateStringTo=dateString?:@"";
    }

    if(![Utilities stringIsNil:dateStringFrom] && ![Utilities stringIsNil:dateStringTo]){
        if([self.delegate respondsToSelector:@selector(rangeDatePickerChangedDate:Date:)])
            [self.delegate rangeDatePickerChangedDate:self Date:[NSString stringWithFormat:@"%@-->>%@",dateStringFrom,dateStringTo]];
    }
}



-(IBAction)btnDoneAction:(id)sender{
    if(![Utilities stringIsNil:dateStringFrom] && ![Utilities stringIsNil:dateStringTo]){
        if([self.delegate respondsToSelector:@selector(rangeDatePickerDismissed:Date:BySingle:)])
            [self.delegate rangeDatePickerDismissed:self Date:[NSString stringWithFormat:@"%@-->%@",dateStringFrom,dateStringTo] BySingle:NO];
    }
    
}

-(IBAction)btnSingleDateAction:(id)sender{
    if(![Utilities stringIsNil:dateStringFrom] && ![Utilities stringIsNil:dateStringTo]){
        if([self.delegate respondsToSelector:@selector(rangeDatePickerDismissed:Date:BySingle:)])
            [self.delegate rangeDatePickerDismissed:self Date:[NSString stringWithFormat:@"%@-->>%@",dateStringFrom,dateStringTo] BySingle:YES];
    }
   
}



-(void)createDividers{
  int  XPOS=15, YPOS=85, Height=2, Width=45, GAP=17;
    
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
    XPOS=15+self.frame.size.width/2;
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
