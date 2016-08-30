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

@interface MatchingViewController ()

@end

@implementation MatchingViewController

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
  switch (self.typeFlicker.selectedSegmentIndex) {
    case 0:
      return self.gameType = 2;
    case 1:
      return self.gameType = 3;
    default:
      return self.gameType = 2;
  }
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" "];
  if([card isChosen]){
    [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:card.contents]];
  }

  return str;
}


-(NSMutableAttributedString *)getCardsAsString{
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" "];

  for(Card *card in self.game.lastHand){
    [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:card.contents]];
    [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];

  }

  return str;
}




- (UIImage *)backgroundImageForCard:(Card *)card{
  return [UIImage imageNamed:card.isChosen ? @"blankRounded" : @"cardback"];
}

- (void)flipCardOnback:(UIButton *)sender{
  [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:(UIControlStateNormal)];
  [sender setTitle:@"" forState:UIControlStateNormal];
}


@end
