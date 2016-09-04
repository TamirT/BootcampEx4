//
//  CardView.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 04/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView

-(void)setCardView:(Card *)card;

@property (nonatomic)CGPoint positionInGrid;

@end
