//
//  ViewController.m
//  DemoCoredatabase
//
//  Created by Mac User5 on 3/31/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate =(AppDelegate *) [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        custome init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.device)
    {
        [_txtname setText:[self.device valueForKey:@"name"]];
        [_txtlastname setText:[self.device valueForKey:@"lastname"]];
        [_txtstudentid setText:[self.device valueForKey:@"studentid"]];
    }
}

-(IBAction)Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    _txtstudentid.text = nil;
    _txtlastname.text = nil;
    _txtname.text = nil;
}

-(IBAction)Save:(id)sender
{
    
    if ([_txtname.text  isEqual: @""] && [ _txtlastname.text isEqual: @"" ] &&  [_txtstudentid.text isEqual: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice" message:@"Please enter your details" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else
    {
        NSManagedObjectContext *context = [self managedObjectContext];

        if (self.device)
        {
            [self.device setValue:self.txtname.text forKey:@"name"];
            [self.device setValue:self.txtlastname.text forKey:@"lastname"];
            [self.device setValue:self.txtstudentid.text forKey:@"studentid"];
        }
        else
        {
            NSManagedObject *newdevice = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:context];
            [newdevice setValue:self.txtname.text forKey:@"name"];
            [newdevice setValue:self.txtlastname.text forKey:@"lastname"];
            [newdevice setValue:self.txtstudentid.text forKey:@"studentid"];
        }
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't save! %@ %@",error ,[error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        _txtstudentid.text = nil;
        _txtlastname.text = nil;
        _txtname.text = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
