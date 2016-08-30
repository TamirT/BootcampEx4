//
//  SetCardDeck.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 25/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

- (instancetype)init{

  self = [super init];

  if (self){
    for(NSString *color in [SetCard validColors]){
      for(NSString *shape in [SetCard validShapes]){
        for(NSInteger number = 1; number <= [SetCard maxInstancesNumber]; number++){
          for(NSString *shade in [SetCard validShades]){
            SetCard *card = [[SetCard alloc] init];
            card.color = color;
            card.shape = shape;
            card.number = number;
            card.shade = shade;
            [self addCard:card];
          }
        }
      }

    }
  }
  return self;
  
}
@end
