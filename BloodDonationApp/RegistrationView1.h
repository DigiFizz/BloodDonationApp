//
//  RegistrationView1.h
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VCRadioButton;
typedef void (^RadioButtonControlSelectionBlock)(VCRadioButton *radioButton);
@interface RegistrationView1 : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
     CGFloat	animatedDistance;
    
    BOOL stateBool;
    BOOL cityBool;
    BOOL areaBool;
    
    NSMutableArray *stareArray;
    NSMutableArray *cityArrray;
    NSMutableArray *areaArray;
    
}

- (IBAction)REGISTRATION2:(id)sender;
@property (copy, nonatomic) RadioButtonControlSelectionBlock selectionBlock;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextfield;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (weak, nonatomic) IBOutlet UITextField *pincodeTextfield;
@property(nonatomic,retain)IBOutlet UITableView *tableView;





@end
