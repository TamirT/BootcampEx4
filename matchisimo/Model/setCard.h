//
//  setCard.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 25/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSInteger number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shade;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSInteger)maxInstancesNumber;
+ (NSArray *)validShades;

@end
