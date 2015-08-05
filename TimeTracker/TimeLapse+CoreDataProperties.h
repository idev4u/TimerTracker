//
//  TimeLapse+CoreDataProperties.h
//  TimeTracker
//
//  Created by Norman Sutorius on 05.08.15.
//  Copyright © 2015 Norman Sutorius. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "TimeLapse.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeLapse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *recordDay;
@property (nullable, nonatomic, retain) NSString *recordState;
@property (nullable, nonatomic, retain) NSDate *startTimestamp;
@property (nullable, nonatomic, retain) NSDate *stopTimestamp;

@end

NS_ASSUME_NONNULL_END
