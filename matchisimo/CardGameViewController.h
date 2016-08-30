//
//  CardGameViewController.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 29/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "ViewController.h"

@interface CardGameViewController : ViewController
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgBox;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeFlicker;
@property (nonatomic) NSInteger gameType;
@property (strong, nonatomic) NSMutableAttributedString *history;


-(void)saveMsgHistory;
-(void)handleMsgBox;
-(void)updateUI;
- (NSMutableAttributedString *)titleForCard:(Card *)card;
@end
