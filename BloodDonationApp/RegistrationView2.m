//
//  RegistrationView2.m
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "RegistrationView2.h"
#import "VCRadioButton.h"

#define kGroup1Name @"group1"
#define kGroup2Name @"group2"

@interface RegistrationView2 ()
@property (weak, nonatomic) IBOutlet VCRadioButton *bloodRadioButton;
@property (weak, nonatomic) IBOutlet VCRadioButton *platetletRadioButton;
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
    
    allBool = 0;
    emailBool=0;
    smsBool=0;
    notificationBool=0;
    
    
    
    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if (radioButton.groupName)
            NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                  radioButton.groupName,
                  (radioButton.selected)? @"selected" : @"deselected",
                  radioButton.selectedValue);
        else
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
    };
    self.bloodRadioButton.selectionBlock = selectionBlock;
    self.platetletRadioButton.selectionBlock = selectionBlock;
    self.CurrntBloodRadioButton.selectionBlock = selectionBlock;
    self.CurrntPlateletsRadioButton.selectionBlock = selectionBlock;
    self.CurrentBothRadioButton.selectionBlock = selectionBlock;
    self.bloodRadioButton.groupName = kGroup1Name;
    self.platetletRadioButton.groupName = kGroup1Name;
    self.CurrntBloodRadioButton.groupName = kGroup2Name;
    self.CurrntPlateletsRadioButton.groupName = kGroup2Name;
    self.CurrentBothRadioButton.groupName = kGroup2Name;
    
    
    self.bloodRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.platetletRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    
    self.CurrntBloodRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.CurrentBothRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.CurrntPlateletsRadioButton.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)notifctionCheckbox:(id)sender
{
    if (notificationBool == 0){
		[notfcnSelected setSelected:YES];
		notificationBool = 1;
	} else {
		[notfcnSelected setSelected:NO];
		notificationBool = 0;
	}
}
- (IBAction)smsCheckbox:(id)sender
{
    if (smsBool == 0){
		[smsSelected setSelected:YES];
		smsBool = 1;
	} else {
		[smsSelected setSelected:NO];
		smsBool = 0;
	}
}

- (IBAction)emailCheckbox:(id)sender
{
    if (emailBool == 0){
		[emailSelected setSelected:YES];
		emailBool = 1;
	} else {
		[emailSelected setSelected:NO];
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
        
		allBool = 1;
        emailBool=1;
        smsBool=1;
        notificationBool=1;

	} else {
		[emailSelected setSelected:NO];
        [smsSelected setSelected:NO];
        [notfcnSelected setSelected:NO];
        [AllSelected setSelected:NO];
		allBool = 0;
        emailBool=0;
        smsBool=0;
        notificationBool=0;

	}
}
@end
