//  CardMatchingGame.m
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"
#define MATCH_BONUS 5;
#define MISMATCH_PENALTY 20;
#define COST_TO_CHOOSE 5;

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic,strong) NSMutableArray *chosen;
@property (nonatomic,strong) NSString *stateMsg;
@property (nonatomic) NSInteger numOfChosen;
@end

@implementation CardMatchingGame


-(NSArray *)lastHand{
  if(!_lastHand){
    _lastHand = [[NSMutableArray alloc] init];
  }
  return _lastHand;
}

- (NSMutableArray *)cards{
  if(!_cards){
    _cards = [[NSMutableArray alloc] init];
  }

  return _cards;
}

- (NSMutableArray *)chosen{
  if(!_chosen){
    _chosen = [[NSMutableArray alloc] init];
  }
  return _chosen;
}

- (NSUInteger)numOfCardsDrawn{
  NSUInteger counter = 0;

  for(Card *card in self.cards){
    if(!card.isMatched){
      counter++;
    }
  }

  return counter;

}

- (NSUInteger)numOfCardsLeft{
  return [self.deck cardsLeft];
}


-(Card *)drawACard{
  Card *card = [self.deck drawRandomCard];

  [self.cards addObject:card];

  return card;
}

-(void)setDeck:(Deck *)deck{
  if(!_deck){
    _deck = deck;
  }
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{

  self = [super init];
  self.deck = deck;
  if(self){
    for(NSInteger i = 0 ; i < count; i++){
      Card *card = [self.deck drawRandomCard];
      if(card){
        self.cards[i] = card;
        continue;
      }
      self = nil;
      break;
    }
  }

  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{

  return (index < [self.cards count])? self.cards[index] : nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index type:(NSInteger)gameType{

  Card *lastCard = self.lastHand.lastObject;
  // reset lastHand array if needed


  // get currently clicked card
  Card *card = [self cardAtIndex:index];
  self.roundScore = - COST_TO_CHOOSE;
  // check if card is unmatched and unchosen to start logic
  if(!card.isMatched){
    if(card.isChosen){
      card.chosen = NO;
      [self.chosen removeObject:card];
      [self.lastHand removeObject:card];
      self.numOfChosen--;
    }else{
      card.chosen = YES;
      self.numOfChosen++;
      [self.lastHand addObject:card];
      self.state = CARD_CHOSEN;
      [self.chosen addObject:card];
      if(self.numOfChosen == gameType){
        self.roundScore = [card match:self.chosen];

        self.score += self.roundScore;
        if(self.roundScore > 0){
          self.state = MATCH;
        }else{
          self.state = PENALTY;
        }
        NSInteger numOfChosen = [self.chosen count];
        for(NSInteger i = numOfChosen - 1 ; i >= 0 ; i--){
          Card *aCard = self.chosen[i];
          if(self.roundScore > 0){
            aCard.chosen = YES;
            aCard.matched = YES;
            [self.chosen removeObjectAtIndex:i];
            self.numOfChosen--;
            continue;
          }else if(aCard != card && !aCard.isMatched){
            aCard.chosen = NO;
            [self.chosen removeObjectAtIndex:i];
            self.numOfChosen--;
          }

        }
      }
    }
  }
  
}

@end