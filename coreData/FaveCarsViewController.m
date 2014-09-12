//
//  FaveCarsViewController.m
//  coreData
//
//  Created by Marcelo Sampaio on 9/12/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "FaveCarsViewController.h"

@interface FaveCarsViewController ()

@end

@implementation FaveCarsViewController
@synthesize textFieldColor,textFieldMake,textFieldModel;
@synthesize car;


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
    if (car) {
        self.textFieldMake.text=[car valueForKey:@"make"];
        self.textFieldModel.text=[car valueForKey:@"model"];
        self.textFieldColor.text=[car valueForKey:@"color"];
    }
}

#pragma mark - UI Actions
- (IBAction)save:(id)sender {
    NSManagedObjectContext *context=[self managedObjectContext];
    if (car) {
        // Update Existing Car
        [car setValue:self.textFieldMake.text forKey:@"make"];
        [car setValue:self.textFieldModel.text forKey:@"model"];
        [car setValue:self.textFieldColor.text forKey:@"color"];
    } else {
        // Create a new car
        NSManagedObject *newCar=[NSEntityDescription insertNewObjectForEntityForName:@"Cars" inManagedObjectContext:context];
        [newCar setValue:textFieldMake.text forKey:@"make"];
        [newCar setValue:textFieldModel.text forKey:@"model"];
        [newCar setValue:textFieldColor.text forKey:@"color"];
    }
    
    NSError *error=nil;
    // Save the context
    if (![context save:&error]) {
        NSLog(@"Error saving data: %@ %@",error,[error localizedDescription]);
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Retrieve and Save Data (Core Data)
-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context=nil;
    
    id delegate=[[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context=[delegate managedObjectContext];
    }
    
    return context;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
