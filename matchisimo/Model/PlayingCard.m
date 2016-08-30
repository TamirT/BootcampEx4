//
//  PlayingCard.m
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

#define MATCH_BONUS 5;
#define MISMATCH_PENALTY 20;
#define COST_TO_CHOOSE 1;

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

-(NSUInteger)rankMatchTwoCards:(PlayingCard *)otherCard{

  NSUInteger score = 0;

  if(self.rank == otherCard.rank){
    score = self.rank;
  }

  return score;
}

-(NSUInteger)match:(NSArray *)otherCards{

  NSUInteger matchStrength = 0;
  NSInteger score = 0;
  score = -COST_TO_CHOOSE;
  BOOL isMatched = false;
  NSUInteger matchScore = 0;
  for(PlayingCard *aCard in otherCards){
    for(PlayingCard *bCard in otherCards){
      if(aCard ==  bCard){
        continue;
      }
      matchScore = [aCard rankMatchTwoCards:bCard];
      if(matchScore){
        matchStrength++;
        score += matchScore * MATCH_BONUS;
        aCard.matched = YES;
        bCard.matched = YES;
        isMatched = YES;
      }
    }

    if(isMatched){
      for(PlayingCard *otherCard in otherCards){
        otherCard.matched = YES;
      }
    } else {
      score = -MISMATCH_PENALTY;
      matchStrength = 1;
    }
  }
      return score * matchStrength;
}
@end
