//  setCard.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 25/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCard.h"

#define MATCH_BONUS 50;
#define MISMATCH_PENALTY 10;
#define COST_TO_CHOOSE 5;

static const NSInteger maxNumberOfShapes = 3;


@implementation SetCard

+ (NSArray *)validShapes{
  return @[@"▲" ,@"●" ,@"■"];
}

+ (NSArray *)validColors{
  return @[@"red" ,@"blue" ,@"green"];
}

+ (NSArray *)validShades{
  return @[@"shade_one" ,@"shade_two" ,@"shade_three"];
}

+(NSInteger)maxInstancesNumber{
  return maxNumberOfShapes;
}

- (NSString *)contents{
  return nil;
}

- (void)setShape:(NSString *)shape{
  if([[SetCard validShapes] containsObject:shape]){
    _shape = shape;
  }
}

- (void)setColor:(NSString *)color{
  if([[SetCard validColors] containsObject:color]){
    _color = color;
  }
}

- (void)setNumber:(NSInteger)number{
  if(number <= maxNumberOfShapes){
    _number = number;
  }
}

-(NSUInteger)match:(NSArray *)otherCards{

  int score = - COST_TO_CHOOSE + MISMATCH_PENALTY;

  bool sameNumber = true;
  bool diffNumber = true;
  bool sameShape = true;
  bool diffShape = true;
  bool sameColor = true;
  bool diffColor = true;
  bool sameShading = true;
  bool diffShading = true;
  for(SetCard *aCard in otherCards){
    for(SetCard *bCard in otherCards){
      if(aCard ==  bCard){
        continue;
      }
      if(aCard.number == bCard.number){
        diffNumber = false;
      }else{
        sameNumber = false;
      }
      if(aCard.shape == bCard.shape){
        diffShape = false;
      }else{
        sameShape = false;
      }
      if(aCard.color == bCard.color){
        diffColor = false;
      }else{
        sameColor = false;
      }
      if(aCard.shade == bCard.shade){
        diffShading = false;
      }else{
        sameShading = false;
      }

    }
  }

  // check if chosen cards are set
  if((sameNumber || diffNumber) && (sameShape || diffShape) && (sameColor || diffColor ) &&
        (sameShading || diffShading)){
    score = score +  MATCH_BONUS + MISMATCH_PENALTY;
  }

  return score;
}


@end
