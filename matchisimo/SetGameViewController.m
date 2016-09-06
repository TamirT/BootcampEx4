//
//  SetGameViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 28/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

#define INITIAL_CARD_COUNT 12

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (NSUInteger)initialCardsCount{
  return INITIAL_CARD_COUNT;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateUI];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}

- (Deck *) createDeck{
  return [[SetCardDeck alloc] init];
}

- (NSInteger)gameType{
  return 3;
}

- (UIColor *)getUIColor:(NSString *)str{

  if([str isEqualToString:@"red"]) return [UIColor blackColor];
  if([str isEqualToString:@"blue"]) return [UIColor grayColor];
  if([str isEqualToString:@"green"]) return [UIColor whiteColor];

  return [UIColor redColor];
  
}

- (void)fixCardsLocations{
  NSUInteger cardCounter = [self.cardViews count];
  for(NSUInteger i = 0 ; i < cardCounter; i++){
    Card *card = [self.game cardAtIndex:i];
    if(!card.isMatched){
       [self fixCardViewPosition:self.cardViews[i]];
    }
  }

}



-(void)updateUI{

  NSUInteger cardsNumber = [self.cardViews count];
  for(NSUInteger i = 0 ; i <  cardsNumber ; i++){
    SetCardView *cardView = self.cardViews[i];
    Card *card = [self.game cardAtIndex:i];
    cardView.chosen = card.isChosen;
    if(card.isMatched){
      cardView.userInteractionEnabled = NO;
      cardView.alpha = 0.2;
      // add animation here for every matched card
      [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                       animations:^{
                         CGFloat x = arc4random_uniform(self.view.frame.size.width);
                         CGFloat y = -100;
                         CGPoint newLoc = CGPointMake(x, y);
                         cardView.positionInGrid = newLoc;
                         cardView.center = newLoc;
                       }
                       completion:^(BOOL finished){
                         NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
                         [self.cardViews removeObject:cardView];
                         [self.game.cards removeObject:card];

                         NSLog([NSString stringWithFormat:@"added slot i : %d" ,cardIndex]);
                         [cardView removeFromSuperview];
                         [self fixCardsLocations];
                       }
       ];
    }else if(cardView.chosen){
      cardView.alpha = 0.7;
    }else{
      cardView.alpha = 1.0;
    }


  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  
}

- (NSShadow *)getShade:(NSString *)str{
  NSShadow *shadow = [[NSShadow alloc] init];
  shadow.shadowOffset = CGSizeMake(1.0, 1.0);
  shadow.shadowBlurRadius = 1.0;
  if([str isEqualToString:@"shade_one"]){
    shadow.shadowColor = [UIColor redColor];
  } else if ([str isEqualToString:@"shade_two"]) {
    shadow.shadowColor = [UIColor blueColor];
  } else {
    shadow.shadowColor = [UIColor greenColor];
  }
  return shadow;
  
}

- (CardView *)createNewCardView{

  return [[SetCardView alloc] init];
}

- (void)tap:(UITapGestureRecognizer *)gesture{
  if ((gesture.state == UIGestureRecognizerStateChanged) ||
      (gesture.state == UIGestureRecognizerStateEnded)) {
    SetCardView *cardView = (SetCardView *)gesture.view;
    NSInteger cardIndex = [self.cardViews indexOfObject:cardView];
    [self.game chooseCardAtIndex:cardIndex type:self.gameType];
    [self updateUI];

  }
}


- (NSMutableAttributedString *)titleForCard:(SetCard *)card{
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@""];
  if(![card isKindOfClass:[SetCard class]]){
    return title;
  }
  for(NSInteger i = 0 ; i < card.number; i++){
    [title appendAttributedString:[[NSMutableAttributedString alloc] initWithString:card.shape]];
  }
  NSRange strRange = NSMakeRange(0, title.length);
  [title addAttribute:NSForegroundColorAttributeName value:[self getUIColor:card.color]
                range:strRange];
  [title addAttribute:NSShadowAttributeName value:[self getShade:card.shade] range:strRange];
  return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
  return [UIImage imageNamed:card.isChosen ? @"pressRounded" : @"blankRounded"];
}

- (void)flipCardOnback:(UIButton *)sender{
  [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:(UIControlStateNormal)];
  [sender setTitle:@"" forState:UIControlStateNormal];
}

@end