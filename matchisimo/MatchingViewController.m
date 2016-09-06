//
//  MatchingViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 25/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "MatchingViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"
#import "PlayingCardView.h"

#define INITIAL_CARD_COUNT 30

@interface MatchingViewController ()

@end

@implementation MatchingViewController

- (NSUInteger)initialCardsCount{
  return INITIAL_CARD_COUNT;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (Deck *) createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (NSInteger)gameType{
    return self.gameType = 3;
}

- (CardView *)createNewCardView{

  return [[PlayingCardView alloc] init];
}



- (NSMutableAttributedString *)titleForCard:(Card *)card{
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" "];
  if([card isChosen]){
    [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:card.contents]];
  }

  return str;
}

-(void)updateUI{

  NSUInteger cardsNumber = [self.cardViews count];
  for(NSUInteger i = 0 ; i <  cardsNumber ; i++){
    PlayingCardView *cardView = self.cardViews[i];
    Card *card = [self.game cardAtIndex:i];
    if(card.isMatched){
      cardView.userInteractionEnabled = NO;
      cardView.alpha = 0.5;
    }else{
      [cardView setFaceUp:card.isChosen];
    }


  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  
}

- (void)tap:(UITapGestureRecognizer *)gesture{

  if ((gesture.state == UIGestureRecognizerStateChanged) ||
      (gesture.state == UIGestureRecognizerStateEnded)) {
    PlayingCardView *cardView = (PlayingCardView *)gesture.view;
    [cardView setFaceUp:!cardView.faceUp];
    NSInteger cardIndex = [self.cardViews indexOfObject:cardView];
    [self.game chooseCardAtIndex:cardIndex type:self.gameType];
    [self updateUI];
  }

}


- (UIImage *)backgroundImageForCard:(Card *)card{
  return [UIImage imageNamed:card.isChosen ? @"blankRounded" : @"cardback"];
}

- (void)flipCardOnback:(UIButton *)sender{
  [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:(UIControlStateNormal)];
  [sender setTitle:@"" forState:UIControlStateNormal];
}


@end
