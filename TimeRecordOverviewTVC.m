//
//  TimeRecordOverviewTVC.m
//  TimeTracker
//
//  Created by Norman Sutorius on 09.08.15.
//  Copyright © 2015 Norman Sutorius. All rights reserved.
//

#import "TimeRecordOverviewTVC.h"
#import "TimeLapse.h"
#import "AppDelegate.h"

static NSString *timeRecordsCell = @"timeRecordsCell";

@interface TimeRecordOverviewTVC () <NSFetchedResultsControllerDelegate, UITableViewDelegate>

@property (nonatomic, strong) NSFetchedResultsController *timeRecordFetcher;

@end

@implementation TimeRecordOverviewTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /* should be get from the timerstartVC*/
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    /* Create the FetchController first action*/
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TimeLapse"];
    //Sorter
    NSSortDescriptor *startTimeStampSorter = [[NSSortDescriptor alloc] initWithKey:@"startTimestamp" ascending:NO];
    
    fetchRequest.sortDescriptors = @[startTimeStampSorter];
    
    self.timeRecordFetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.timeRecordFetcher.delegate = self;
    NSError *fetchError = nil;
    if([self.timeRecordFetcher performFetch:&fetchError]){
        NSLog(@"timerRecordOverviewTVC: successfully fetched.");
    } else {
        NSLog(@"timerRecordOverviewTVC: failed to fetched.");
    }
    //thi sfixed the crash after open the view
    self.timeRecordFetcher.delegate = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id<NSFetchedResultsSectionInfo> sectionInfo = self.timeRecordFetcher.sections[section];
    if (sectionInfo.numberOfObjects <= 10) {
        NSLog(@"index is smaller then 10");
    }
    return sectionInfo.numberOfObjects;
}
//
//#pragma add the section
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return self.timeRecordFetcher.sections[section];
//}

#pragma mark - Controller Section
- (void) controllerWillChangeContent:(nonnull NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

- (void) controller:(nonnull NSFetchedResultsController *)controller
    didChangeObject:(nonnull __kindof NSManagedObject *)anObject
    atIndexPath:(nullable NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
    newIndexPath:(nullable NSIndexPath *)newIndexPath{
    
    if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (type == NSFetchedResultsChangeInsert){
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

- (void) controllerDidChangeContent:(nonnull NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:timeRecordsCell forIndexPath:indexPath];
    
    // Configure the cell...
    TimeLapse *timeLapse = [self.timeRecordFetcher objectAtIndexPath:indexPath];
    
    //DateFormatter
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatterDate setDateStyle:NSDateFormatterShortStyle];
    [formatterDate setTimeStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *cellMessage = timeLapse.recordState;
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:1];
    label1.text = cellMessage;
     //    cell.textLabel.text = [formatter stringFromDate:timeLapse.startTimestamp];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    _timerDisplay.numberOfLines = 0;
//    _timerDisplay.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.textLabel.text = [cellMessage stringByAppendingFormat:[formatter stringFromDate:timeLapse.startTimestamp]];
    UILabel *label10 = (UILabel *)[cell.contentView viewWithTag:10];
    label10.numberOfLines = 0;
    label10.lineBreakMode = NSLineBreakByWordWrapping;
    [label10 setText:[formatter stringFromDate:timeLapse.startTimestamp]];
    
    UILabel *label20 = (UILabel *)[cell.contentView viewWithTag:20];
    label20.numberOfLines = 0;
    label20.lineBreakMode = NSLineBreakByWordWrapping;
    [label20 setText:[formatter stringFromDate:timeLapse.stopTimestamp]];

    NSLog(@"timelapse Start: %@", timeLapse.startTimestamp);
    NSLog(@"timelapse StatusText: %@", timeLapse.recordState);
    NSLog(@"timelapse Stop: %@", timeLapse.stopTimestamp);

//    cell.detailTextLabel.text = [formatter stringFromDate:timeLapse.stopTimestamp];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma init CoreData Context
- (NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end
