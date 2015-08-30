

#import "DatePicker.h"

@interface DatePicker ()

@end

@implementation DatePicker

-(id)initWithFrame:(CGRect)frame Properties:(NSDictionary*)properties
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[properties valueForKey:DatePickerBackgroundColor]?[properties valueForKey:DatePickerBackgroundColor] :[UIColor lightGrayColor];
       
        tableWidth=[properties valueForKey:DatePickerTableWidth]?[[properties valueForKey:DatePickerTableWidth] floatValue]:40;
        tableInterGap=[properties valueForKey:DatePickerTableInterGap]?[[properties valueForKey:DatePickerTableInterGap] floatValue]:5;
        rowHeight=[properties valueForKey:DatePickerTableRowHeight]?[[properties valueForKey:DatePickerTableRowHeight] floatValue]:40;
        
        fontNormal=[properties valueForKey:DatePickerTableFontNormal]?( [properties valueForKey:DatePickerTableFontNormal] ):[UIFont systemFontOfSize:12.0];
        fontSelected=[properties valueForKey:DatePickerTableFontSelected]?( [properties valueForKey:DatePickerTableFontSelected] ):[UIFont systemFontOfSize:13.0];
        
        colorNormal=[properties valueForKey:DatePickerTableFontColorNormal]?[properties valueForKey:DatePickerTableFontColorNormal] :[UIColor blackColor];
        colorSelected=[properties valueForKey:DatePickerTableFontColorSelected]?[properties valueForKey:DatePickerTableFontColorSelected] :[UIColor grayColor];
        
        repeatCounts=100;
        NSString* dateString;
        NSDate *currDate = [NSDate date];
        
        dateString = [Utilities StringFromDate:currDate Format:@"MM" Local:YES];
        selectedMonth=[dateString intValue];
        
        dateString = [Utilities StringFromDate:currDate Format:@"YYYY" Local:YES];
        selectedYear=[YEARS indexOfObject:dateString]+1;
        
        dateString = [Utilities StringFromDate:currDate Format:@"dd" Local:YES];
        selectedDay=[dateString intValue];
        
        
        [self loadTableViews];
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    if([self.delegate respondsToSelector:@selector(datePickerChangedDate:Date:)])
        [ self.delegate datePickerChangedDate:self Date:[NSString stringWithFormat:@"%ld-%ld-%@",selectedDay,selectedMonth,[YEARS objectAtIndex:selectedYear-1]]];
    
}


-(void)loadTableViews{
 
    int XPOS=0,YPOS=0,height=self.frame.size.height;
    
    yearsTableView=[[UITableView alloc]initWithFrame:CGRectMake(XPOS+2*(tableWidth+tableInterGap), YPOS, tableWidth, height)];
    yearsTableView.dataSource=self;
    yearsTableView.delegate=self;
    yearsTableView.rowHeight=rowHeight;
    yearsTableView.showsVerticalScrollIndicator=NO;
    yearsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:yearsTableView];
    
    monthsTableView=[[UITableView alloc]initWithFrame:CGRectMake(XPOS+tableWidth+tableInterGap, YPOS, tableWidth, height)];
    monthsTableView.dataSource=self;
    monthsTableView.delegate=self;
    monthsTableView.rowHeight=rowHeight;
    monthsTableView.showsVerticalScrollIndicator=NO;
    monthsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:monthsTableView];
    
    
    dayTableView=[[UITableView alloc]initWithFrame:CGRectMake(XPOS, YPOS, tableWidth, height)];
    dayTableView.dataSource=self;
    dayTableView.delegate=self;
    dayTableView.rowHeight=rowHeight;
    dayTableView.showsVerticalScrollIndicator=NO;
    dayTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:dayTableView];
    
    [self reloadYears];
    [self reloadMonths];
    [self reloadDaysForMonth:selectedMonth Year:selectedYear];
    
    
    
}

-(void)reloadYears{
    
    yearsArray=[[NSMutableArray alloc]initWithArray:YEARS];
    
    yearIndexFullLength=selectedYear-1;
    yearIndexFullLength=yearIndexFullLength+8*[yearsArray count];
    
    [yearsTableView reloadData];
    [yearsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:yearIndexFullLength inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}


-(void)reloadMonths{
    
    monthsArray=[[NSMutableArray alloc]initWithArray:MONTHS];
    
    monthIndexFullLength=selectedMonth-1;
    monthIndexFullLength=monthIndexFullLength+8*[monthsArray count];
    
    [monthsTableView reloadData];
    [monthsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:monthIndexFullLength inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

-(void)reloadDaysForMonth:(long)month Year:(long)year{
    NSDate*date=[Utilities DateTimeFromString:[NSString stringWithFormat:@"%ld-%ld-01",year, month] Format:DATE_FORMAT_2 UTC:NO];
    dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    daysArray=[[NSMutableArray alloc]init];
    for (int i =1; i<=dayRange.length; i++) {
        [daysArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    dayIndexFullLength=selectedDay-1;
    dayIndexFullLength=dayIndexFullLength+8*[daysArray count];
    
    [dayTableView reloadData];
    [dayTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:dayIndexFullLength inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}

- (NSInteger)numberOfSections;{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    long count=0;
    
    if ([tableView isEqual:dayTableView])
        count= [daysArray count]*repeatCounts;
    
    else if ([tableView isEqual:monthsTableView])
        count= [monthsArray count]*repeatCounts;
    
    else if  ([tableView isEqual:yearsTableView])
        count= [yearsArray count]*repeatCounts;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font=fontNormal;
    
    if ([tableView isEqual:dayTableView]) {
        
        cell.textLabel.text = [daysArray objectAtIndex:indexPath.row % [daysArray count]];
        
        if(indexPath.row==dayIndexFullLength){
            cell.textLabel.textColor=colorSelected;
            cell.textLabel.font=fontSelected;
        }
        
        else
            cell.textLabel.textColor=colorNormal;
        
    }
    
    else if ([tableView isEqual:monthsTableView]) {
        cell.textLabel.text = [monthsArray objectAtIndex:indexPath.row % [monthsArray count]];
        
        if(indexPath.row==monthIndexFullLength){
            cell.textLabel.textColor=colorSelected;
            cell.textLabel.font=fontSelected;
        }
        
        else cell.textLabel.textColor=colorNormal;
    }
    
    else  if ([tableView isEqual:yearsTableView]) {
        cell.textLabel.text = [yearsArray objectAtIndex:indexPath.row % [yearsArray count]];
        
        if(indexPath.row==yearIndexFullLength){
            cell.textLabel.textColor=colorSelected;
            cell.textLabel.font=fontSelected;
        }
        else
            cell.textLabel.textColor=colorNormal;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int offset,rowIndex;
    
    if([scrollView isEqual:dayTableView]){
        offset=floor(scrollView.contentOffset.y/rowHeight);
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)scrollView.contentOffset.y/rowHeight;
        rowIndex++;
        
        dayIndexFullLength=rowIndex;
        selectedDay=(dayIndexFullLength%[daysArray count])+1;
        [dayTableView reloadData];
    }
    
    else  if([scrollView isEqual:monthsTableView]){
        offset=floor(scrollView.contentOffset.y/rowHeight);
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)scrollView.contentOffset.y/rowHeight;
        rowIndex++;
        
        monthIndexFullLength=rowIndex;
        unsigned long prevMonth=selectedMonth;
        selectedMonth=(monthIndexFullLength%[MONTHS count])+1;
        [monthsTableView reloadData];
      
        
        if([self maxDayOfMonthByMonth:prevMonth Year:selectedYear]>[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear]){
            long maxDay=[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear];
            
            if(selectedDay>maxDay)
                selectedDay=maxDay;
        }
        
         [self reloadDaysForMonth:selectedMonth Year:selectedYear];
    }
    
    else  if([scrollView isEqual:yearsTableView]){
        offset=floor(scrollView.contentOffset.y/rowHeight);
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)scrollView.contentOffset.y/rowHeight;
        rowIndex++;
        
        yearIndexFullLength=rowIndex;
        selectedYear=(yearIndexFullLength%[YEARS count])+1;
        [yearsTableView reloadData];
        
        
        if(selectedMonth==2){
            long maxDay=[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear];
            
            if(selectedDay>maxDay)
                selectedDay=maxDay;
        }
        
        [self reloadDaysForMonth:selectedMonth Year:selectedYear];
    }
    
    if([self.delegate respondsToSelector:@selector(datePickerChangedDate:Date:)])
        [ self.delegate datePickerChangedDate:self Date:[NSString stringWithFormat:@"%ld-%ld-%@",selectedDay,selectedMonth,[YEARS objectAtIndex:selectedYear-1]]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate)
        return;
    
    int offsetLooping;
    int offset,rowIndex;
    
    if([scrollView isEqual:dayTableView]){
        offsetLooping = 1;
        offset=floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        rowIndex++;
        
        dayIndexFullLength=rowIndex;
        selectedDay=(dayIndexFullLength%[daysArray count])+1;
        [dayTableView reloadData];
    }
    
    else  if([scrollView isEqual:monthsTableView]){
        offsetLooping = 1;
        offset=floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        rowIndex++;
        
        monthIndexFullLength=rowIndex;
         unsigned long prevMonth=selectedMonth;
        selectedMonth=(monthIndexFullLength%[MONTHS count])+1;
        [monthsTableView reloadData];
        
        if([self maxDayOfMonthByMonth:prevMonth Year:selectedYear]>[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear]){
            long maxDay=[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear];
            
            if(selectedDay>maxDay)
                selectedDay=maxDay;
        }
        
        [self reloadDaysForMonth:selectedMonth Year:selectedYear];
    }
    
    else  if([scrollView isEqual:yearsTableView]){
        offsetLooping = 1;
        offset=floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,offset*rowHeight) animated:YES];
        rowIndex  =(int)floor((scrollView.contentOffset.y - rowHeight / 2) / rowHeight) + offsetLooping;
        rowIndex++;
        
        yearIndexFullLength=rowIndex;
        selectedYear=(yearIndexFullLength%[YEARS count])+1;
        [yearsTableView reloadData];
        
        if(selectedMonth==2){
            long maxDay=[self maxDayOfMonthByMonth:selectedMonth Year:selectedYear];
            
            if(selectedDay>maxDay)
                selectedDay=maxDay;
        }
        
        [self reloadDaysForMonth:selectedMonth Year:selectedYear];
    }
    
    
    if([self.delegate respondsToSelector:@selector(datePickerChangedDate:Date:)])
        [ self.delegate datePickerChangedDate:self Date:[NSString stringWithFormat:@"%ld-%ld-%@",selectedDay,selectedMonth,[YEARS objectAtIndex:selectedYear-1]]];
    
}

-(long)maxDayOfMonthByMonth:(long)month Year:(long)year{
    
    if(month==2){
         return [[MAX_DAY_OF_FEB objectAtIndex:year-1] longValue];
    }
    else{
        return [[MAX_DAY_OF_MONTH objectAtIndex:month-1] longValue];
    }
}




@end
