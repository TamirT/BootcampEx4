//
//  PlayingCard.m
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;



- (NSString *)suit{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4", @"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
