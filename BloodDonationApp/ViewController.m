//
//  ViewController.m
//  BloodDonationApp
//
//  Created by digifizz on 22/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "ViewController.h"
#import "Menu_Cell.h"
@interface ViewController ()

@end

@implementation ViewController

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
        label.text=@"Blood Donation App";
//        label.text = NSLocalizedString(@"PageThreeTitle", @"");
        [label sizeToFit];

        
              // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    
    

    [super viewDidLoad];
    menuArray=[[NSMutableArray alloc]init];
    [menuArray addObject:@"Login"];
    [menuArray addObject:@"Register as Donor"];
    [menuArray addObject:@"Search Donor"];
    [menuArray addObject:@"Search Blood Manks"];
    [menuArray addObject:@"Upcoming Blood Donation Camps"];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellidentifier=@"Menu_Cell";
    Menu_Cell *cell=(Menu_Cell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell==nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Menu_Cell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
    cell.menu_Image.image=[UIImage imageNamed:@"menudemo.png"];
    cell.menu_Label.text=[menuArray objectAtIndex:indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
