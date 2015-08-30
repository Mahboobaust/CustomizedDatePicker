//
//  CustomizedDatePickerViewController.m
//  CustomizedDatePicker
//
//  Created by Mahboob on 8/30/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import "CustomizedDatePickerViewController.h"

@interface CustomizedDatePickerViewController ()

@end

@implementation CustomizedDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear
{
    //  objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft);
  }

- (NSUInteger)supportedInterfaceOrientations {
    UIDeviceOrientation  deviceOrientation;
    if (IDIOM==IPAD){// [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // iPad: Allow all orientations
        return UIInterfaceOrientationMaskAll;
         //deviceOrientation= (UIDeviceOrientation)UIInterfaceOrientationPortrait;
    } else {
        // iPhone: Allow only landscape
        deviceOrientation= (UIDeviceOrientation)UIInterfaceOrientationMaskLandscape;
    }
    return deviceOrientation;
}
- (void)viewDidLoad
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];

    isSingle=YES;
    isRange=YES;
    [super viewDidLoad];
    self.view.backgroundColor=UIColorFromRGB(0x095E75);
    [_btnSingle addTarget:self action:@selector(loadSinglePicker) forControlEvents:UIControlEventTouchUpInside];
  
   // [_btnRange addTarget:self action:@selector(loadRangePicker) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSinglePicker{
    if (customSingleDatePicker) {
        [self removeSinglePicker];
        isSingle=YES;
    }
    
    if (isSingle) {
        _btnSingle.hidden=YES;
        [self removeRangePicker];
        if (IDIOM==IPAD) {
            customSingleDatePicker = [[[NSBundle mainBundle] loadNibNamed:@"CustomSingleDatePicker" owner:self options:nil] objectAtIndex:0];
            customSingleDatePicker.frame=CGRectMake(250, 38, 216,210);
            customSingleDatePicker.delegate=self;
            [self.view addSubview:customSingleDatePicker];
            
            
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                customSingleDatePicker.frame=CGRectMake(250, 72+38, customSingleDatePicker.frame.size.width, 210);
            } completion:^(BOOL finished) {
                [UIView commitAnimations];
            }];

        }
        
        else
        {
            customSingleDatePicker = [[[NSBundle mainBundle] loadNibNamed:@"CustomSingleDatePicker" owner:self options:nil] objectAtIndex:0];
            customSingleDatePicker.frame=CGRectMake(150, 0, 216,210);
            customSingleDatePicker.delegate=self;
            [self.view addSubview:customSingleDatePicker];
            
            
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                customSingleDatePicker.frame=CGRectMake(150, 38, customSingleDatePicker.frame.size.width, 210);
            } completion:^(BOOL finished) {
                [UIView commitAnimations];
            }];

        
        }
        
    }
    isSingle=NO;
}

-(void)singleDatePickerDismissed:(CustomSingleDatePicker*)singleDatePicker Date:(NSString*)dateString ByRange:(BOOL)range{
     _lblDate.text=dateString;
    
    if (range)
    {
         [self loadRangePicker];
        isSingle=YES;
    }
    
    
    [self removeSinglePicker];
}

-(void)singleDatePickerChangedDate:(CustomSingleDatePicker*)singleDatePicker Date:(NSString*)dateString{
     _lblDate.text=dateString;
  
}

-(void)removeSinglePicker{
    if(customSingleDatePicker){
        [customSingleDatePicker removeFromSuperview];
        customSingleDatePicker=nil;
    }
    _btnSingle.hidden=NO;
}

- (void)loadRangePicker{
   
    if (isRange) {
        [self removeSinglePicker];
        
        if (IDIOM==IPAD) {
            customRangeDatePicker = [[[NSBundle mainBundle] loadNibNamed:@"CustomRangeDatePicker" owner:self options:nil] objectAtIndex:0];
            customRangeDatePicker.frame=CGRectMake(200, 38, 400, 0);
            customRangeDatePicker.delegate=self;
            [self.view addSubview:customRangeDatePicker];
            
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                customRangeDatePicker.frame=CGRectMake(200, 72+38, 400, 212);
            } completion:^(BOOL finished) {
                [UIView commitAnimations];
            }];

        }
        else
        {
            customRangeDatePicker = [[[NSBundle mainBundle] loadNibNamed:@"CustomRangeDatePicker" owner:self options:nil] objectAtIndex:0];
            customRangeDatePicker.frame=CGRectMake(50, 0, 400, 0);
            customRangeDatePicker.delegate=self;
            [self.view addSubview:customRangeDatePicker];
            
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                customRangeDatePicker.frame=CGRectMake(50,38, 400, 212);
            } completion:^(BOOL finished) {
                [UIView commitAnimations];
            }];

        
        }
        
      
    }
   }


-(void)rangeDatePickerDismissed:(CustomRangeDatePicker*)singleDatePicker Date:(NSString*)dateString BySingle:(BOOL)single
{
    
    _lblDate.text=dateString;
    if (single)
    {
        [self loadSinglePicker];
        isSingle=single;
    }
    
    
    [self removeRangePicker];
}

-(void)rangeDatePickerChangedDate:(CustomRangeDatePicker*)singleDatePicker Date:(NSString*)dateString
{
     _lblDate.text=dateString;
}


-(void)removeRangePicker{
    if(customRangeDatePicker){
        [customRangeDatePicker removeFromSuperview];
        customRangeDatePicker=nil;
    }
    _btnSingle.hidden=NO;
}


@end
