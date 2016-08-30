//
//  Card.m
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"

@implementation Card

-(NSUInteger)match:(NSArray *)otherCards{
    
    int score = 0;
    for (Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end