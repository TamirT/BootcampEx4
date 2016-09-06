//
//  CardGameViewController.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 29/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
#import "Grid.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : ViewController
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgBox;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeFlicker;
@property (nonatomic) NSInteger gameType;
@property (strong, nonatomic) NSMutableAttributedString *history;
@property (strong, nonatomic) Deck * deck;
@property (strong, nonatomic)NSMutableArray *cardViews;
@property (strong, nonatomic) Grid *grid;

-(void)updateUI;
- (NSMutableAttributedString *)titleForCard:(Card *)card;
- (CGRect)calculateDeckFrame;
- (CardView *)addCard:(Card *)card;
- (NSUInteger)initialCardsCount;
- (CGPoint)indexToPointInGrid:(NSUInteger)index;
- (void)fixCardViewPosition: (CardView * )cardView;
@end
