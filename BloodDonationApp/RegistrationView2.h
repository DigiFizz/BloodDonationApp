//
//  RegistrationView2.h
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VCRadioButton;
typedef void (^RadioButtonControlSelectionBlock)(VCRadioButton *radioButton);
//#import "RadioButton.h"
@interface RegistrationView2 : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    BOOL smsBool;
    BOOL notificationBool;
    BOOL emailBool;
    BOOL allBool;
    BOOL phoneBool;
    
    
    
    NSMutableDictionary *reg1DataDictionary;
    NSInteger notificationCheck;
    NSInteger smsCheck;
    NSInteger emailCheck;
    NSInteger phoneCheck;
    NSString *Device_id;
    
    NSString *yetDonatedString;
    NSString *readyDonatedString;
    
    IBOutlet UIButton *notfcnSelected;
    IBOutlet UIButton *emailSelected;
    IBOutlet UIButton *smsSelected;
    IBOutlet UIButton *phoneSelected;
    IBOutlet UIButton *AllSelected;
}




@property (copy, nonatomic) RadioButtonControlSelectionBlock selectionBlock;
@property (strong, nonatomic) id selectedValue;
@property (weak, nonatomic) IBOutlet UITextField *bloodgroup;
@property (weak, nonatomic) IBOutlet UITextField *recentlyDonatedDate;

- (IBAction)keyboardhide:(id)sender;
- (IBAction)phoneCheck:(id)sender;

- (IBAction)notifctionCheckbox:(id)sender;

- (IBAction)smsCheckbox:(id)sender;
- (IBAction)emailCheckbox:(id)sender;

- (IBAction)allCheckbox:(id)sender;

- (IBAction)SubmitRegistration:(id)sender;
@property (nonatomic,retain) IBOutlet UIDatePicker *Datepicker;
@property(nonatomic,retain)IBOutlet UIView *dateview;





@end
