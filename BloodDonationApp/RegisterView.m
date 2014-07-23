//
//  RegisterView.m
//  BloodDonationApp
//
//  Created by digifizz on 23/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "RegisterView.h"
#import "RegistrationView1.h"
@interface RegisterView ()

@end

@implementation RegisterView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        //        label.backgroundColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        //        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        // ^-Use UITextAlignmentCenter for older SDKs.
        label.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = label;
        label.text=@"Registration";
        //        label.text = NSLocalizedString(@"PageThreeTitle", @"");
        [label sizeToFit];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RegisterApp:(id)sender
{
    
    RegistrationView1 *Reg1=[[RegistrationView1 alloc]init];
    [self.navigationController pushViewController:Reg1 animated:YES];
}

- (IBAction)GoogleReg:(id)sender
{
    RegistrationView1 *Reg1=[[RegistrationView1 alloc]init];
    [self.navigationController pushViewController:Reg1 animated:YES];
}

- (IBAction)TwitterReg:(id)sender
{
    RegistrationView1 *Reg1=[[RegistrationView1 alloc]init];
    [self.navigationController pushViewController:Reg1 animated:YES];
}

- (IBAction)fbReg:(id)sender
{
    RegistrationView1 *Reg1=[[RegistrationView1 alloc]init];
    [self.navigationController pushViewController:Reg1 animated:YES];
}
@end
