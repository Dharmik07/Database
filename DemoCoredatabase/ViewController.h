//
//  ViewController.h
//  DemoCoredatabase
//
//  Created by Mac User5 on 3/31/17.
//  Copyright © 2017 Mac04. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtname;
@property (strong, nonatomic) IBOutlet UITextField *txtlastname;
@property (strong, nonatomic) IBOutlet UITextField *txtstudentid;
@property (strong) NSManagedObject *device;

-(IBAction)Cancel:(id)sender;
-(IBAction)Save:(id)sender;

@end

