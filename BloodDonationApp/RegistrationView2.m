//
//  RegistrationView2.m
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "RegistrationView2.h"
#import "VCRadioButton.h"
#import "AppDelegate.h"
#import <AdSupport/AdSupport.h>
#import "WebMethod.h"

#define kGroup1Name @"group1"
#define kGroup2Name @"group2"

@interface RegistrationView2 ()
@property (weak, nonatomic) IBOutlet VCRadioButton *bloodRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *platetletRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *bothRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *CurrntBloodRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *CurrntPlateletsRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *CurrentBothRadioButton;



@end

@implementation RegistrationView2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//   _dateview=[[UIView alloc]initWithFrame:CGRectMake(0, 124, 320, 162)];
//    [_dateview setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:_dateview];
//    CGRect pickerFrame = CGRectMake(0,0,320,162);
//    
//    _Datepicker= [[UIDatePicker alloc] initWithFrame:pickerFrame];
////    [myPicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
//    [_dateview addSubview:_Datepicker];
//    
//    [_dateview setHidden:YES];
    

    
    
    NSString *deviceUDID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    Device_id = [[deviceUDID
                            stringByReplacingOccurrencesOfString:@"-" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
     NSLog(@"Device is is %@",Device_id);
    allBool = 0;
    emailBool=0;
    smsBool=0;
    phoneBool=0;
    notificationBool=0;
    reg1DataDictionary=[[NSMutableDictionary alloc]init];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
   reg1DataDictionary=delegate.reg1Dictionary;
 
    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if (radioButton.groupName)
        {
            NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                  radioButton.groupName,
                  (radioButton.selected)? @"selected" : @"deselected",
                  radioButton.selectedValue);
            NSString *selectvalue=radioButton.selectedValue;
            if( ([selectvalue isEqualToString:@"Blood"])||([selectvalue isEqualToString:@"Platelets"])||([selectvalue isEqualToString:@"Both"]))
            {
                yetDonatedString=radioButton.selectedValue;
            }
            else
            {
             
                NSString *currntystring=radioButton.selectedValue;
                if ([currntystring isEqualToString:@"Blood Current"])
                {
                   readyDonatedString=@"Blood";
                }
                else if ([currntystring isEqualToString:@"Platelets Currennt"])
                {
                    readyDonatedString=@"Platelets";
                }
                else
                {
                    readyDonatedString=@"Both";
                }
            }
            NSLog(@"yet selected %@ and ready %@",yetDonatedString,readyDonatedString);
        }
        
        else
        {
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
        }
    };
    self.bloodRadioButton.selectionBlock = selectionBlock;
    self.platetletRadioButton.selectionBlock = selectionBlock;
    self.bothRadioButton.selectionBlock=selectionBlock;
    
    
    
    self.CurrntBloodRadioButton.selectionBlock = selectionBlock;
    self.CurrntPlateletsRadioButton.selectionBlock = selectionBlock;
    self.CurrentBothRadioButton.selectionBlock = selectionBlock;
    
    
    self.bloodRadioButton.groupName = kGroup1Name;
    self.platetletRadioButton.groupName = kGroup1Name;
    self.bothRadioButton.groupName=kGroup1Name;
    
    self.CurrntBloodRadioButton.groupName = kGroup2Name;
    self.CurrntPlateletsRadioButton.groupName = kGroup2Name;
    self.CurrentBothRadioButton.groupName = kGroup2Name;
    
    
    
    // set value in radio button
    self.bloodRadioButton.selectedValue=@"Blood";
    self.platetletRadioButton.selectedValue=@"Platelets";
    self.bothRadioButton.selectedValue=@"Both";
    
    self.CurrntBloodRadioButton.selectedValue=@"Blood Current";
    self.CurrntPlateletsRadioButton.selectedValue=@"Platelets Currennt";
    self.CurrentBothRadioButton.selectedValue=@"Both Current";
    
    
    
    self.bloodRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.platetletRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
     self.bothRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    
    
    self.CurrntBloodRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.CurrentBothRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.CurrntPlateletsRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
}



#pragma UItextField Delegate Called

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_bloodgroup)
    {
        [textField resignFirstResponder];
    }
    else if (textField==_recentlyDonatedDate)
    {
        [textField resignFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    
    if (textField==_recentlyDonatedDate)
    {
//        [textField resignFirstResponder];
//        [_dateview setHidden:NO];
        
    }
    
}
//- (void)pickerChanged:(id)sender
//{
//    NSLog(@"value: %@",[sender date]);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keyboardhide:(id)sender
{
    [_Datepicker setHidden:YES];
    [self.view endEditing:YES];
}

- (IBAction)phoneCheck:(id)sender
{
    if (phoneBool == 0)
    {
		[phoneSelected setSelected:YES];
        phoneCheck=1;
		phoneBool = 1;
	}
    else
    {
		[phoneSelected setSelected:NO];
        phoneCheck=0;
		phoneBool = 0;
	}
}

- (IBAction)notifctionCheckbox:(id)sender
{
    if (notificationBool == 0)
    {
		[notfcnSelected setSelected:YES];
        notificationCheck=1;
		notificationBool = 1;
	} else {
		[notfcnSelected setSelected:NO];
        notificationCheck=0;
		notificationBool = 0;
	}
}
- (IBAction)smsCheckbox:(id)sender
{
    if (smsBool == 0)
    {
		[smsSelected setSelected:YES];
        smsCheck=1;
		smsBool = 1;
	}
    else
    {
		[smsSelected setSelected:NO];
        smsCheck=0;
		smsBool = 0;
	}
}

- (IBAction)emailCheckbox:(id)sender
{
    if (emailBool == 0)
    {
		[emailSelected setSelected:YES];
        emailCheck=1;
		emailBool = 1;
	}
    else
    {
		[emailSelected setSelected:NO];
        emailCheck=0;
		emailBool = 0;
	}
}

- (IBAction)allCheckbox:(id)sender
{
    
    
      if (allBool == 0)
    {
		[AllSelected setSelected:YES];
        [smsSelected setSelected:YES];
        [emailSelected setSelected:YES];
        [notfcnSelected setSelected:YES];
        [phoneSelected setSelected:YES];
        notificationCheck=1;
        emailCheck=1;
        smsCheck=1;
        phoneCheck=1;
        allBool = 1;
        emailBool=1;
        smsBool=1;
        notificationBool=1;
        phoneBool=1;
        

	} else {
		[emailSelected setSelected:NO];
        [smsSelected setSelected:NO];
        [notfcnSelected setSelected:NO];
        [phoneSelected setSelected:NO];
        [AllSelected setSelected:NO];
        notificationCheck=0;
        emailCheck=0;
        smsCheck=0;
        phoneCheck=0;
     
		allBool = 0;
        emailBool=0;
        smsBool=0;
        phoneBool=0;
        notificationBool=0;

	}
}

- (IBAction)SubmitRegistration:(id)sender
{
    NSString *name=[reg1DataDictionary objectForKey:@"name"];
    NSString *gender=[reg1DataDictionary objectForKey:@"gender"];
    NSInteger age=[[reg1DataDictionary objectForKey:@"age"] intValue];
    NSInteger mobile=[[reg1DataDictionary objectForKey:@"mobile"]intValue];
    NSString *email=[reg1DataDictionary objectForKey:@"email"];
    NSString *state=[reg1DataDictionary objectForKey:@"state"];
    NSString *city=[reg1DataDictionary objectForKey:@"city"];
    NSString *loaction=[reg1DataDictionary objectForKey:@"location"];
   NSInteger pincode=[[reg1DataDictionary objectForKey:@"pincode"] intValue];
//    NSString *gender=[reg1DataDictionary objectForKey:@"gender"];
    
    if (_bloodgroup.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Enter the Blood Group" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (_recentlyDonatedDate.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Enter the Recently Donated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (yetDonatedString.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select Donated Yet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (readyDonatedString.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please Select Ready to Donate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [WebMethod Deviceid:Device_id Name:name Email:email Mobile:mobile Age:age Gender:gender Donartype:readyDonatedString BloodGroup:_bloodgroup.text DateRecentlyDonated:_recentlyDonatedDate.text TypeRecentlyDonated:yetDonatedString State:state City:city area:loaction pincode:pincode SMS:smsCheck email:emailCheck pmcMobile:phoneCheck pmcNotification:notificationCheck];
    }

    
    
    
    
    
    
    
    
    
    
}




@end
