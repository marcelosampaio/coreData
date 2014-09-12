//
//  FaveCarsTableViewController.m
//  coreData
//
//  Created by Marcelo Sampaio on 9/12/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "FaveCarsTableViewController.h"

@interface FaveCarsTableViewController ()

@end

@implementation FaveCarsTableViewController
@synthesize cars;

#pragma mark - Initialization
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // get the cars from pur persistant store
    NSManagedObjectContext *moc=[self managedObjectContext];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]initWithEntityName:@"Cars"];
    cars=[[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    [self.tableView reloadData];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSManagedObject *car=[self.cars objectAtIndex:indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",[car valueForKey:@"make"],[car valueForKey:@"model"]];
    cell.detailTextLabel.text=[car valueForKey:@"color"];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete from data base (Core Data)
        [context deleteObject:[self.cars objectAtIndex:indexPath.row]];
        
        // Save method
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Fail to delete record in database. %@ %@",error,[error localizedDescription]);
            return;
        }
        
        
        // Remove from data source array
        [self.cars removeObjectAtIndex:indexPath.row];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue***");
    if ([segue.identifier isEqualToString:@"updateCar"]) {
        NSLog(@"inside loaing property");
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        NSManagedObject *selectedCar=[self.cars objectAtIndex:indexPath.row];
        FaveCarsViewController *destinationViewController=segue.destinationViewController;
        destinationViewController.car=selectedCar;
    }
}


@end
