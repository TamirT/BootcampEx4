//  CardGameViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 29/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  HistoryViewController *destView = segue.destinationViewController;
  [destView.historyLogger appendAttributedString:self.history];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CardMatchingGame *)game{
  if(!_game){
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:self.deck];
  }

  return _game;
}

- (NSMutableAttributedString *)history{
  if(!_history){
    _history = [[NSMutableAttributedString alloc] init];
  }
  return _history;
}

- (NSInteger)gameType{
  return 0;
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
  return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex type:self.gameType];
  [self updateUI];
}

- (void)saveMsgHistory{
  if(self.game.state == CARD_CHOSEN){
    return;
  }
  [self.history appendAttributedString:self.msgBox.attributedText];
  [self.history appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@". "]];
  [self.history appendAttributedString:self.scoreLabel.attributedText];
  [self.history appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\r\r"]];
}

- (UIImage *)backgroundImageForCard:(Card *)card{
  return nil;
}

-(void)updateUI{
  for(UIButton *cardButton in self.cardButtons){
    NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardIndex];
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage: [self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];

  [self handleMsgBox];
  [self saveMsgHistory];
}

-(NSMutableAttributedString *)getCardsAsString{
  return nil;
}

- (void)handleMsgBox{
  GameState state = self.game.state;
  NSString * roundScore = [NSString stringWithFormat:@"%ld", (long)self.game.roundScore];
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
  switch (state) {
    case PENALTY:
      [str appendAttributedString:[self getCardsAsString]];
      [str appendAttributedString:[[NSMutableAttributedString alloc]
                                   initWithString:@" do not match! Penality: "]];
      [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:roundScore]];
      self.msgBox.attributedText = str;
      break;
    case MATCH:
      [str appendAttributedString:[self getCardsAsString]];
      [str appendAttributedString:[[NSMutableAttributedString alloc]
                                   initWithString:@" match!  Round Score: "]];
      [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:roundScore]];
      self.msgBox.attributedText = str;
      break;
    case CARD_CHOSEN:
      [str appendAttributedString:[[NSMutableAttributedString alloc]
                                   initWithString:@"Choose Another Card"]];
      self.msgBox.attributedText = str;
      break;
    case GAME_END:
      [str appendAttributedString:[[NSMutableAttributedString alloc]
                                   initWithString:@"Game finished! reset to play again"]];
      self.msgBox.attributedText = str;
      break;
    case NEW_GAME:
    default:
      [str appendAttributedString:[[NSMutableAttributedString alloc]
                                   initWithString:@"Start Game!"]];
      self.msgBox.attributedText = str;
      break;
  }
}

- (IBAction)reset:(id)sender {
  self.game = nil;
  self.deck = nil;
  self.scoreLabel.text = @"Score : 0";
  [self updateUI];
}
- (IBAction)gameTypeChanged:(id)sender {
  [self reset:sender];
}



@end
