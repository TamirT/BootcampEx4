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
@property (strong, nonatomic)CardView *deckCardView;

@property (nonatomic) CGSize currentCardSize;
@property (strong, nonatomic)NSTimer* timer;
@property (nonatomic) BOOL gameInitialized;

@property (strong, nonatomic)UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic)UIPinchGestureRecognizer *pinchGestureRecognizer;

@end

@implementation CardGameViewController


- (NSUInteger)initialCardsCount{
  return 0;
}

-(NSMutableArray *)cardViews{
  if(!_cardViews){
    _cardViews = [[NSMutableArray alloc] init];
  }
  return _cardViews;
}

- (NSInteger)gameType{
  return 3;
}

- (CardMatchingGame *)game{
  if(!_game){
    _game = [[CardMatchingGame alloc] init];
    [_game setDeck:self.deck];
  }

  return _game;
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
                                            action:@selector(dealThreeCardsFromDeck:)];
    [_deckCardView addGestureRecognizer:tap];

  }

  return _deckCardView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.gameView addGestureRecognizer:self.pinchGestureRecognizer];
  NSLog(@"IN VIEW DID LOAD");

}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

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
  CGPoint gridPoint = [self indexToPointInGrid:[self.cardViews count]];
  cardView.positionInGrid = gridPoint;
  cardView.frame = [self.grid frameOfCellAtRow:gridPoint.y inColumn:gridPoint.x];
  cardView.center = [self.grid centerOfCellAtRow:gridPoint.y inColumn:gridPoint.x];

  [self.gameView addSubview:cardView];
}

-(UIPinchGestureRecognizer *)pinchGestureRecognizer{
  if(!_pinchGestureRecognizer){
    _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(pinch:)];
  }
  return _pinchGestureRecognizer;
}



- (IBAction)reset:(id)sender {
  self.game = nil;
  self.deck = nil;
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

- (void)pinch:(UIPinchGestureRecognizer *)gesture{
  if(gesture.state == UIGestureRecognizerStateBegan ||
     gesture.state == UIGestureRecognizerStateChanged){
    for(CardView *cardView in self.cardViews){
      [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                       animations:^{
                         CGPoint point = CGPointMake(self.gameView.frame.size.height / 2,
                                                     self.gameView.frame.size.width / 2);
                         cardView.center = point;
                       }
                       completion:^(BOOL finished){}];
    }
  }else if (gesture.state == UIGestureRecognizerStateEnded){
    [self fixCardsLocations];
  }

}

- (CGRect)calculateDeckFrame{
  CGSize deckSize = [self.grid cellSize];
  CGFloat xPos = 3 * self.gameView.bounds.size.width / 4;
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

  NSUInteger freeIndex = [self.cardViews count];
  CGPoint pointInGrid = [self indexToPointInGrid:freeIndex];
  Card *card = [self.game drawACard];

  NSUInteger cardsDrawn = [self.game numOfCardsDrawn];
  NSUInteger cardsLeft = [self.game numOfCardsLeft];

  CardView *cardView = [self createCardViewFromCard:card];
  [self.gameView addSubview:cardView];

                       if(cardsDrawn == [self initialCardsCount] || cardsLeft == 0){
                         [self.timer invalidate];
                         self.timer = nil;
                       }

  [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     cardView.positionInGrid = pointInGrid;
                     cardView.center = [self.grid centerOfCellAtRow:cardView.positionInGrid.y
                                                           inColumn:cardView.positionInGrid.x];
                     if(cardsDrawn == [self initialCardsCount] || cardsLeft == 0){
                       [self.timer invalidate];
                       self.timer = nil;
                     }
                   }
                   completion:^(BOOL finished){}];
}

- (void)dealThreeCardsFromDeck:(UITapGestureRecognizer*)recognizer{
  [self dealCardFromDeck:nil];
  [self dealCardFromDeck:nil];
  [self dealCardFromDeck:nil];
}

- (CardView *)createNewCardView{
  return nil;
}

- (CardView *)createCardViewFromCard:(Card *)card{
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


@end
