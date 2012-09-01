//
//  Sample.h
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sample : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * v;

@end
