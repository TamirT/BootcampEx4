//
//  PlayingCard.h
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
