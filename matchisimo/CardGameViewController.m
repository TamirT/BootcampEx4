//  CardGameViewController.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 29/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "Grid.h"
#import "PlayingCardView.h"
#import "Card.h"

#define INITIAL_CARD_COUNT 54
#define MAX_CELL_HEIGHT 70

@interface CardGameViewController ()
@property (strong, nonatomic)UIDynamicAnimator *animator;
@property (strong, nonatomic)IBOutlet UIView *gameView;
@property (strong, nonatomic)NSMutableArray *freeCardSlots;
@property (strong, nonatomic)NSMutableArray *playingCardViews;
@property (nonatomic) BOOL gameInitialized;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) CGSize currentCardSize;
@end

@implementation CardGameViewController

-(NSMutableArray *)freeCardSlots{
  if(!_freeCardSlots){

    NSUInteger cardRowCount = [self.grid rowCount];
    NSUInteger cardColumnCount = [self.grid columnCount];

    _freeCardSlots = [[NSMutableArray alloc] init];

    for(NSUInteger i = 0 ; i < cardRowCount * cardColumnCount ; i++){
      [_freeCardSlots addObject:@YES];
    }
  }

  return _freeCardSlots;
}

-(NSMutableArray *)playingCardViews{
  if(!_playingCardViews){
    _playingCardViews = [[NSMutableArray alloc] init];
    NSUInteger cardsCount = [self.game numOfCardsDrawn];
    for(NSUInteger i = 0 ; i < cardsCount; i++){
      Card *card = [self.game cardAtIndex:i];
      if(!card.isMatched){
        [self addPlayingCard:card];
      }
    }

  }
  return _playingCardViews;
}

-(CGPoint)nextFreeSlotCenter{

  NSUInteger slotCount = [self.freeCardSlots count];
  for(NSUInteger i = 0 ; i < slotCount ; i++){
    if([self.freeCardSlots[i] boolValue]){
      self.freeCardSlots[i] = @NO;
      CGFloat x = i % self.grid.columnCount;
      CGFloat y = i - x;
      return [self.grid centerOfCellAtRow:y inColumn:x];
    }
  }
  return CGPointMake(-1, -1);
}

-(CGPoint)indexToPointInGrid:(NSUInteger)index{

  NSUInteger x = index % self.grid.columnCount;
  NSUInteger y = floor(index / self.grid.columnCount);

  return CGPointMake(x, y);
}

-(void)fixCardViewPosition: (PlayingCardView * )cardView{
  // check if playing card view already attached to game view
  if([self.playingCardViews containsObject:cardView]){
    NSUInteger cardViewIndex = [self.playingCardViews indexOfObject:cardView];
    CGPoint pointInGrid = [self indexToPointInGrid:cardViewIndex];
    cardView.frame = [self.grid frameOfCellAtRow:(NSUInteger)pointInGrid.y inColumn:(NSUInteger)pointInGrid.x];
    return;
  }

  // add playing card view to game view
  NSUInteger slotCount = [self.freeCardSlots count];
  for(NSUInteger i = 0 ; i < slotCount ; i++){
    if([self.freeCardSlots[i] boolValue]){
      self.freeCardSlots[i] = @NO;

      CGPoint gridPoint = [self indexToPointInGrid:i];
      cardView.positionInGrid = [self.grid centerOfCellAtRow:gridPoint.y inColumn:gridPoint.x];
      cardView.frame = [self.grid frameOfCellAtRow:gridPoint.y inColumn:gridPoint.x];
      break;
    }
  }

  [self.gameView addSubview:cardView];

}


-(void)occupySlot:(NSUInteger)x :(NSUInteger)y{

  NSUInteger width = self.grid.size.width;
  if( self.grid.size.height < y || self.grid.size.width < x ){
    self.freeCardSlots[y * width + x] = @NO;
  }

}

- (UIDynamicAnimator *)animator{
  if(!_animator){
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
  }

  return _animator;
}

- (Deck *) createDeck{
  return nil;
}


- (Deck *) deck{
  if(!_deck){
    _deck = [self createDeck];
  }
  return _deck;
}


- (Grid *)grid{
  if(!_grid){
    _grid = [[Grid alloc] init];
    _grid.cellAspectRatio = 0.71;
    _grid.maxCellHeight = MAX_CELL_HEIGHT;
    _grid.size = self.gameView.frame.size;
    _grid.minimumNumberOfCells = 5;
    NSLog([NSString stringWithFormat:@"Grid Adjusted Row : %d , Col : %d",
           _grid.rowCount,_grid.columnCount]);
  }

  return _grid;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  HistoryViewController *destView = segue.destinationViewController;
  [destView.historyLogger appendAttributedString:self.history];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"IN VIEW DID LOAD");

  //  [self setup];
  // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
  NSLog(@"in view did layoutSubview");
  self.grid = nil;

  if(!self.gameInitialized){
    [self dealCardsFromDeck];
    self.gameInitialized = YES;
  }

  [self fixCardsLocations];
  //  NSLog(@"%d", [[self.gameView subviews] count]);
  //  NSLog(@"%d", [self.playingCardViews count]);
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (CardMatchingGame *)game{
  if(!_game){
    _game = [[CardMatchingGame alloc] initWithCardCount:INITIAL_CARD_COUNT
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

  //  [self handleMsgBox];
  //  [self saveMsgHistory];
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
  [self fixCardsLocations];
  [self updateUI];
}

- (IBAction)gameTypeChanged:(id)sender {
  [self reset:sender];
}

- (PlayingCardView *)addPlayingCard:(Card *)card{
  PlayingCardView *cardView = [[PlayingCardView alloc] init];
  cardView.frame = [self calculateDeckFrame];
  [cardView setCardView:card];

  [self.playingCardViews addObject:cardView];
  return cardView;
}

- (CGRect)calculateDeckFrame{
  CGSize deckSize = [self.grid cellSize];
  CGFloat xPos = self.gameView.bounds.size.width / 2;
  CGFloat yPos = self.gameView.bounds.size.height - MAX_CELL_HEIGHT;

  return CGRectMake(xPos, yPos, deckSize.width, deckSize.height);
}

- (void)fixCardsLocations{
  NSUInteger cardCounter = [self.playingCardViews count];
  for(NSUInteger i = 0 ; i < cardCounter; i++){
    [self fixCardViewPosition:self.playingCardViews[i]];
  }

}

- (void)setup{

  // create pile
  //  CGPoint cardPoint =  [self.grid centerOfCellAtRow:2 inColumn:2];

  //dealNewCards

}

-(void)dealCardsFromDeck{

  for(PlayingCardView *card in self.playingCardViews){
    NSUInteger cardViewIndex = [self.playingCardViews indexOfObject:card];
    CGPoint pointInGrid = [self indexToPointInGrid:cardViewIndex];
    [self.gameView addSubview:card];
    card.positionInGrid = pointInGrid;
    [UIView animateWithDuration:1.0
                     animations:^{
                       NSUInteger x = card.positionInGrid.x;
                       NSUInteger y = card.positionInGrid.y;
                       card.center = [self.grid centerOfCellAtRow:y inColumn:x];
                     }];
//    [NSThread sleepForTimeInterval:1.0f];
  }
}


@end
