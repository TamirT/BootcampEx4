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


@interface SetGameViewController ()

@end

@implementation SetGameViewController



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

- (NSShadow *)getShadow:(NSString *)str{
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

-(NSMutableAttributedString *)getCardsAsString{
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];

  for(Card *card in self.game.lastHand){
    [str appendAttributedString:[self titleForCard:card]];
    [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "]];

  }

  return str;
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
  [title addAttribute:NSShadowAttributeName value:[self getShadow:card.shade] range:strRange];
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