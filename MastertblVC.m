//
//  MastertblVC.m
//  DemoCoredatabase
//
//  Created by Mac User5 on 3/31/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

#import "MastertblVC.h"
#import "Custome.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface MastertblVC ()

@property (strong, nonatomic) NSMutableArray *devices;

@end

@implementation MastertblVC

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

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
//        Custome initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor clearColor];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footerView;

}

-(void)viewDidAppear:(BOOL)animated
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Students"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Custome *acell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSManagedObjectModel *device = [_devices objectAtIndex:indexPath.row];

//    Print in label
    [acell.lblStudentid setText:[device valueForKey:@"studentid"]];
    [acell.lblStudentname setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"],[device valueForKey:@"lastname"]]];

    return acell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [context deleteObject:[_devices objectAtIndex:indexPath.row]];
    }
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't delete! %@ %@",error , [error localizedDescription]);
        return;
    }
    [_devices removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (IBAction)AddData:(id)sender
{
    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UpdateDevice"])
    {
        NSManagedObject *selectdevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        ViewController *destinationVC = segue.destinationViewController;
        destinationVC.device = selectdevice;
    }
}

@end
