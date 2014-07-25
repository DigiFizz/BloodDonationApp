//
//  RegistrationView1.m
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "RegistrationView1.h"
#import "RegistrationView2.h"
#import "AppDelegate.h"
#import "VCRadioButton.h"
#import "WebMethod.h"
#define kGroup1Name @"group1"
#define kGroup2Name @"group2"
@interface RegistrationView1 ()
{
    NSString *genderString;
  
}
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
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
//   WebMethod *web=[[WebMethod alloc]init];
//      [web requestserver:@"http://server.digifizz.in/blood_user/area.php"];
    if (textField==_stateTextField)
    {

  
        
        stareArray=delegate.statearray;
        stateBool=true;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(98, 261, 276, 218) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
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
         [self.view setBackgroundColor:[UIColor redColor]];
        [UIView commitAnimations];
         [textField resignFirstResponder];
        
        
    }
    else if (textField==_cityTextfield)
    {
        
        
        if (stareArray.count==0)
        {
            [textField resignFirstResponder];

            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"Please Fill State First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertview show];
        
        }
        else
        {
            cityBool=true;
//            [web GetCity:1];
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(98, 110, 276, 218) style:UITableViewStyleGrouped];
            _tableView.delegate=self;
            _tableView.dataSource=self;
            [self.view addSubview:_tableView];
            
           
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
            [self.view setBackgroundColor:[UIColor redColor]];
             [UIView commitAnimations];
            [textField resignFirstResponder];

            
        }
       
    }
    else if (textField==_areaTextField)
    {
        
        if (cityArrray.count==0)
        {
            [textField resignFirstResponder];
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"Please Fill City First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertview show];
        }
        else
        {
        areaBool=true;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(98, 149, 276, 218) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
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
            [self.view setBackgroundColor:[UIColor redColor]];
            [UIView commitAnimations];

            [textField resignFirstResponder];
        }
	}
    else if (textField==_pincodeTextfield)
    {
        if (areaArray.count==0)
        {
            [textField resignFirstResponder];
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"Please Fill Area First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertview show];
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
            [self.view setBackgroundColor:[UIColor redColor]];
            [UIView commitAnimations];

             [textField resignFirstResponder];
        }
       
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
         [self.view setBackgroundColor:[UIColor redColor]];
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
     [self.view setBackgroundColor:[UIColor redColor]];
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
        
        if((_mobileTextfield.text.length<10) || (_mobileTextfield.text.length>10))
        {
            
           ;
            UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter the mobile no up to 10." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [msg show];
            
        }
        else
        {
        [textField resignFirstResponder];
        [_emailTextfield becomeFirstResponder];
        }
    }
    else
    {
        
        if ([self NSStringIsValidEmail:_emailTextfield.text]!=true)
            
        {
            
            UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter the Valid Email Address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [msg show];
            
        }
        else
        {
          [textField resignFirstResponder];
        }
    }
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    WebMethod *web=[[WebMethod alloc]init];
    [web requestserver:@"http://server.digifizz.in/blood_user/area.php"];
    
    
    stareArray=[[NSMutableArray alloc]init];
    cityArrray=[[NSMutableArray alloc]init];
    areaArray=[[NSMutableArray alloc]init];

    

    
    
    

    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if (radioButton.groupName)
        {
            NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                  radioButton.groupName,
                  (radioButton.selected)? @"selected" : @"deselected",
                  radioButton.selectedValue);
        genderString=radioButton.selectedValue;
        }
        else
        {
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
            
            genderString=radioButton.selectedValue;
        }
    };
    
    self.Malebtn.selectionBlock = selectionBlock;
    self.Femalebtn.selectionBlock = selectionBlock;
    
    
    
    self.Malebtn.groupName = kGroup1Name;
    self.Femalebtn.groupName = kGroup1Name;
    self.Malebtn.selectedValue=@"Male";
    self.Femalebtn.selectedValue=@"Female";
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
        cell.textLabel.text=[[stareArray objectAtIndex:indexPath.row] objectForKey:@"region_name"];
    }
    if (cityBool==true)
    {
        cell.textLabel.text=[[cityArrray objectAtIndex:indexPath.row] objectForKey:@"city_name"];
    }
    if (areaBool==true)
    {
        cell.textLabel.text=[[areaArray objectAtIndex:indexPath.row] objectForKey:@"location"];;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebMethod *webServiceMethod=[[WebMethod alloc]init];
 
    if (stateBool==true)
    {
        _stateTextField.text=[[stareArray objectAtIndex:indexPath.row] objectForKey:@"region_name"];
      cityArrray=[webServiceMethod GetCity:[[[stareArray objectAtIndex:indexPath.row] objectForKey:@"region_code"] integerValue]];
        
        stateBool=false;
        [_tableView removeFromSuperview];
    }
    if (cityBool==true)
    {
        _cityTextfield.text=[[cityArrray objectAtIndex:indexPath.row] objectForKey:@"city_name"];
        
        areaArray=[WebMethod GetLocation:[[[cityArrray objectAtIndex:indexPath.row] objectForKey:@"city_code"] intValue]];
        
        cityBool=false;
        [_tableView removeFromSuperview];
    }
    if (areaBool==true)
    {
        _areaTextField.text=[[areaArray objectAtIndex:indexPath.row] objectForKey:@"location"];
        _pincodeTextfield.text=[[areaArray objectAtIndex:indexPath.row] objectForKey:@"location_code"];
        areaBool=false;
    [_tableView removeFromSuperview];
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (stateBool==true)
    {
        return @"Select State";
    }
    else if (cityBool==true)
    {
        return @"Select City";
    }
    else
     return @"Select Location";
}



#pragma Validation on textfield

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _mobileTextfield)
    {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];       NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                                                                                                                       options:0
                                                                                                                                                         range:NSMakeRange(0, [newString length])];
        
        if (numberOfMatches == 0)
            return NO;
    }
    
  else    if (textField == _ageTextfield)
    {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];       NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                                                                                                                       options:0
                                                                                                                                                         range:NSMakeRange(0, [newString length])];
        
        if (numberOfMatches == 0)
            return NO;
    }

    
    
    return YES;
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}




- (IBAction)hidekeyboard:(id)sender
{
    [_nameTextfield resignFirstResponder];
    [_ageTextfield resignFirstResponder];
    [_mobileTextfield resignFirstResponder];
    [_emailTextfield resignFirstResponder];
    [self.tableView removeFromSuperview];
    [self.view endEditing:YES];
   
}

- (IBAction)REGISTRATION2:(id)sender
{
    
    
    
    if (_nameTextfield.text.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
    else if (_ageTextfield.text.length==0)
    
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter your Age" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
    else if(_mobileTextfield.text.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
    else if (_emailTextfield.text.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
   else if (_stateTextField.text.length==0)
   {
       UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter State" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       [msg show];
   }
      else if(_cityTextfield.text.length==0)
      {
          UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter City" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
          [msg show];
      }
    else if (_areaTextField.text.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
     else if(_pincodeTextfield.text.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please select Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
    else if (genderString.length==0)
    {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:nil message:@"Please Select Gender" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [msg show];
    }
    else
    {
        
        
        if((_mobileTextfield.text.length<10) || (_mobileTextfield.text.length>10))
        {
            
            //[self mobileServiceCall];
            UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter the mobile no up to 10." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [msg show];
            
        }
        else if ([self NSStringIsValidEmail:_emailTextfield.text]!=true)
            
        {
            
            UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter the Valid Email Address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [msg show];
            
        }
        

        
        else
    {
        
        NSMutableDictionary *reg1Data=[[NSMutableDictionary alloc]init];
        [reg1Data setObject:_nameTextfield.text forKey:@"name"];
         [reg1Data setObject:genderString forKey:@"gender"];
         [reg1Data setObject:_ageTextfield.text forKey:@"age"];
         [reg1Data setObject:_mobileTextfield.text forKey:@"mobile"];
         [reg1Data setObject:_emailTextfield.text forKey:@"email"];
         [reg1Data setObject:_stateTextField.text forKey:@"state"];
         [reg1Data setObject:_cityTextfield.text forKey:@"city"];
         [reg1Data setObject:_areaTextField.text forKey:@"location"];
         [reg1Data setObject:_pincodeTextfield.text forKey:@"pincode"];
          AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        delegate.reg1Dictionary=reg1Data;
        
        RegistrationView2 *reg2=[[RegistrationView2 alloc]init];
        [self.navigationController pushViewController:reg2 animated:YES];
        }
    }
    

//    RegistrationView2 *reg2=[[RegistrationView2 alloc]init];
//    [self.navigationController pushViewController:reg2 animated:YES];
   
    
}
@end
