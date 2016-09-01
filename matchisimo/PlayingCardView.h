//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Martin Mandl on 12.11.13.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewProtocol.h"

@interface PlayingCardView : UIView <CardViewProtocol>

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGPoint positionInGrid;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;


@end
