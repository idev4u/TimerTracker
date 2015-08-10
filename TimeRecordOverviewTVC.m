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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    /* Create the FetchController first action*/
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TimeLapse"];
    //Sorter
    NSSortDescriptor *startTimeStampSorter = [[NSSortDescriptor alloc] initWithKey:@"startTimestamp" ascending:YES];
    
    fetchRequest.sortDescriptors = @[startTimeStampSorter];
    
    self.timeRecordFetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.timeRecordFetcher.delegate = self;
    NSError *fetchError = nil;
    if([self.timeRecordFetcher performFetch:&fetchError]){
        NSLog(@"timerRecordOverviewTVC: successfully fetched.");
    } else {
        NSLog(@"timerRecordOverviewTVC: failed to fetched.");
    }

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
    return sectionInfo.numberOfObjects;
}

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
     //    cell.textLabel.text = [formatter stringFromDate:timeLapse.startTimestamp];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    _timerDisplay.numberOfLines = 0;
//    _timerDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = [cellMessage stringByAppendingFormat:[formatter stringFromDate:timeLapse.startTimestamp]];

    NSLog(@"timelapse Start: %@", timeLapse.startTimestamp);
    NSLog(@"timelapse StatusText: %@", timeLapse.recordState);
    NSLog(@"timelapse Stop: %@", timeLapse.stopTimestamp);

    cell.detailTextLabel.text = [formatter stringFromDate:timeLapse.stopTimestamp];
    
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

@end
