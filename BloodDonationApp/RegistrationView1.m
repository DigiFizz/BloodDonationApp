//
//  RegistrationView1.m
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "RegistrationView1.h"
#import "RegistrationView2.h"
#import "VCRadioButton.h"
#define kGroup1Name @"group1"
#define kGroup2Name @"group2"
@interface RegistrationView1 ()
@property (weak, nonatomic) IBOutlet VCRadioButton *Malebtn;
@property (weak, nonatomic) IBOutlet VCRadioButton *Femalebtn;
@end

@implementation RegistrationView1
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_stateTextField)
    {
        [textField resignFirstResponder];
        
        stateBool=true;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(24, 261, 276, 218) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
        
    }
    else if (textField==_cityTextfield)
    {
        
        [textField resignFirstResponder];
        
        cityBool=true;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(24, 110, 276, 218) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
    }
    else if (textField==_areaTextField)
    {
        [textField resignFirstResponder];
        areaBool=true;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(24, 149, 276, 218) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
	}
    else if (textField==_pincodeTextfield)
    {
        [textField resignFirstResponder];
    }
    else
    {
        CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
        CGFloat heightFraction = numerator / denominator;
        if (heightFraction < 0.0)
        {
            heightFraction = 0.0;
        }
        else if (heightFraction > 1.0)
        {
            heightFraction = 1.0;
        }
        UIInterfaceOrientation orientation =
        [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        }
        else
        {
            animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
        }
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	CGRect viewFrame = self.view.frame;
	viewFrame.origin.y += animatedDistance;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	[self.view setFrame:viewFrame];
 	[UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _nameTextfield) {
        [textField resignFirstResponder];
        [_ageTextfield becomeFirstResponder];
    } else if (textField == _ageTextfield)
    {
        [textField resignFirstResponder];
        [_mobileTextfield becomeFirstResponder];
        
        // here you can define what happens
        // when user presses return on the email field
    }
    else if (textField==_mobileTextfield)
    {
        
        [textField resignFirstResponder];
        [_emailTextfield becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    stareArray=[[NSMutableArray alloc]init];
    cityArrray=[[NSMutableArray alloc]init];
    areaArray=[[NSMutableArray alloc]init];
    
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
    
    self.Malebtn.selectionBlock = selectionBlock;
    self.Femalebtn.selectionBlock = selectionBlock;
    
    
    
    self.Malebtn.groupName = kGroup1Name;
    self.Femalebtn.groupName = kGroup1Name;
    self.Malebtn.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.Femalebtn.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (stateBool==true)
    {
        return  stareArray.count;
    }
    else if (cityBool==true)
    {
        return cityArrray.count;
    }
    else if (areaBool==true)
    {
        return  areaArray.count;
    }
    else
        return 0;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString *cellidentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    
    if (stateBool==true)
    {
        cell.textLabel.text=[stareArray objectAtIndex:indexPath.row];
    }
    if (cityBool==true)
    {
        cell.textLabel.text=[cityArrray objectAtIndex:indexPath.row];
    }
    if (areaBool==true)
    {
        cell.textLabel.text=[areaArray objectAtIndex:indexPath.row];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (stateBool==true)
    {
        _stateTextField.text=[stareArray objectAtIndex:indexPath.row];
        stateBool=false;
        [_tableView removeFromSuperview];
    }
    if (cityBool==true)
    {
        _cityTextfield.text=[cityArrray objectAtIndex:indexPath.row];
        cityBool=false;
        [_tableView removeFromSuperview];
    }
    if (areaBool==true)
    {
        _areaTextField.text=[areaArray objectAtIndex:indexPath.row];
        areaBool=false;
        [_tableView removeFromSuperview];
    }
}






- (IBAction)REGISTRATION2:(id)sender
{
    RegistrationView2 *reg2=[[RegistrationView2 alloc]init];
    [self.navigationController pushViewController:reg2 animated:YES];
}
@end
