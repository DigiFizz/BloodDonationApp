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
@interface RegistrationView2 : UIViewController
{
    BOOL smsBool;
    BOOL notificationBool;
    BOOL emailBool;
    BOOL allBool;
     IBOutlet UIButton *notfcnSelected;
    
    IBOutlet UIButton *emailSelected;
    
    IBOutlet UIButton *smsSelected;
    
     IBOutlet UIButton *AllSelected;
}




@property (copy, nonatomic) RadioButtonControlSelectionBlock selectionBlock;
@property (strong, nonatomic) id selectedValue;
//@property (weak, nonatomic)  RadioButton *Group;
- (IBAction)notifctionCheckbox:(id)sender;

- (IBAction)smsCheckbox:(id)sender;
- (IBAction)emailCheckbox:(id)sender;

- (IBAction)allCheckbox:(id)sender;

@end
