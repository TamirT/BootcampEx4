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
#import "CardView.h"

#define MAX_CELL_HEIGHT 60
#define GAME_TYPE 3

@interface CardGameViewController ()
@property (strong, nonatomic)IBOutlet UIView *gameView;
@property (strong, nonatomic)NSMutableArray *freeCardSlots;
@property (nonatomic) BOOL gameInitialized;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) CGSize currentCardSize;
@property (strong, nonatomic)CardView *deckCardView;
@property (strong, nonatomic)NSTimer* timer;
@property (strong, nonatomic)UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation CardGameViewController


- (NSUInteger)initialCardsCount{
  return 0;
}

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

-(NSMutableArray *)cardViews{
  if(!_cardViews){
    _cardViews = [[NSMutableArray alloc] init];
  }
  return _cardViews;
}


// Returns a CGPoint in the grid to plot the next card
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

// Turns an index in the cardView array to an
// CGPoint in the grid, representing the card's location.
-(CGPoint)indexToPointInGrid:(NSUInteger)index{

  NSUInteger x = index % self.grid.columnCount;
  NSUInteger y = floor(index / self.grid.columnCount);

  return CGPointMake(x, y);
}

// Gets the correct grid point position for a card view.
-(void)fixCardViewPosition: (CardView * )cardView{
  // check if playing card view already attached to game view

  if([self.cardViews containsObject:cardView]){
    NSUInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
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
  }

  return _grid;
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
  [self.deckCardView removeFromSuperview];
  self.deckCardView = nil;
  [self deckCardView];
  if(!self.gameInitialized){
    [self initialDealCardsFromDeck];
    self.gameInitialized = YES;
  }

  [self fixCardsLocations];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (CardMatchingGame *)game{
  if(!_game){
    _game = [[CardMatchingGame alloc] init];
    [_game setDeck:self.deck];
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

- (UIImage *)backgroundImageForCard:(Card *)card{
  return nil;
}

-(NSMutableAttributedString *)getCardsAsString{
  return nil;
}

- (IBAction)reset:(id)sender {
  self.game = nil;
  self.deck = nil;
  self.freeCardSlots = nil;
  self.gameInitialized = NO;
  self.grid = nil;
  self.deckCardView = nil;

  for(CardView *card in self.cardViews){
    [card removeFromSuperview];
  }
  self.scoreLabel.text = @"Score : 0";

  self.cardViews = nil;
  [self viewDidLayoutSubviews];


}
- (IBAction)gameTypeChanged:(id)sender {
  [self reset:sender];
}

- (void)tap:(UITapGestureRecognizer *)gesture{
  // implement in inheriting class
}

-(void)updateUI{
  // implement in inherting class
}

- (CGRect)calculateDeckFrame{
  CGSize deckSize = [self.grid cellSize];
  CGFloat xPos = self.gameView.bounds.size.width / 2;
  CGFloat yPos = self.gameView.bounds.size.height - MAX_CELL_HEIGHT;

  return CGRectMake(xPos, yPos, deckSize.width, deckSize.height);
}

- (void)fixCardsLocations{
  NSUInteger cardCounter = [self.cardViews count];
  for(NSUInteger i = 0 ; i < cardCounter; i++){
    [self fixCardViewPosition:self.cardViews[i]];
  }

}

-(void)dealCardFromDeck:(UITapGestureRecognizer *)recognizer{

  // if initial card count met, stop dealing timer


  if ([self.deck cardsLeft] == 1){
    [self.deckCardView removeFromSuperview];
  }

  // add + animate addition of new card
  Card *card = [self.game drawACard];

  NSUInteger cardsDrawn = [self.game numOfCardsDrawn];
  NSUInteger cardsLeft = [self.game numOfCardsLeft];

  CardView *cardView = [self addCard:card];
  NSUInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
  CGPoint pointInGrid = [self indexToPointInGrid:cardViewIndex];
  [self.gameView addSubview:cardView];
  cardView.positionInGrid = pointInGrid;

  [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     NSUInteger x = cardView.positionInGrid.x;
                     NSUInteger y = cardView.positionInGrid.y;
                     cardView.center = [self.grid centerOfCellAtRow:y inColumn:x];
                     if(cardsDrawn == [self initialCardsCount] || cardsLeft == 0){
                       [self.timer invalidate];
                       self.timer = nil;
                     }
                   }
                   completion:^(BOOL finished){}
   ];
}

- (CardView *)createNewCardView{

  return nil;
}

- (CardView *)addCard:(Card *)card{
  CardView *cardView = [self createNewCardView];
  cardView.frame = [self calculateDeckFrame];
  [cardView setCardView:card];

  UITapGestureRecognizer *tapGestureRecognizer =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(tap:)];
  [cardView addGestureRecognizer:tapGestureRecognizer];

  [self.cardViews addObject:cardView];
  return cardView;
}

-(void)initialDealCardsFromDeck{

  if([self initialCardsCount] == 0){
    return;
  }

  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                target:self selector:@selector(dealCardFromDeck:)
                                              userInfo:nil repeats:YES];
}

-(CardView *)deckCardView{

  if(!_deckCardView){
    if([self.deck cardsLeft] == 0){
      return nil;
    }
    _deckCardView = [[PlayingCardView alloc] init];
    _deckCardView.frame = [self calculateDeckFrame];
    [self.gameView addSubview:_deckCardView];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dealCardFromDeck:)];
    [_deckCardView addGestureRecognizer:tap];

  }
  
  return _deckCardView;
}

@end
