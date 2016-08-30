//
//  CardMatchingGame.h
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject



- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index type:(NSInteger)gameType;

typedef enum{
    NEW_GAME,
    PENALTY,
    MATCH,
    CARD_CHOSEN,
    GAME_END
    
} GameState;

@property(nonatomic,readonly) NSInteger score;
@property (nonatomic, readwrite) NSInteger roundScore;
@property (nonatomic) GameState state;
@property (nonatomic, strong) NSMutableArray *lastHand;

@end
