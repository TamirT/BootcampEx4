//
//  SetCardView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 04/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"

@implementation SetCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

@synthesize positionInGrid = _positionInGrid;

- (CGPoint)positionInGrid{
  return _positionInGrid;
}

- (void)setPositionInGrid:(CGPoint)positionInGrid
{
  _positionInGrid = positionInGrid;
  [self setNeedsDisplay];
}

-(void)setCardView:(Card *)card{

//  if([card isKindOfClass:[PlayingCard class]]){
//
    SetCard *playCard = (SetCard *)card;
    [self setNumber:playCard.number];
    [self setShade:playCard.shade];
    [self setShape:playCard.shape];
    [self setColor:playCard.color];

}

- (void)setNumber:(NSUInteger)number{
  _number = number;
  [self setNeedsDisplay];
}

- (void)setSshape:(NSString *)shape{
  _shape = shape;
  [self setNeedsDisplay];
}

- (void)setColor:(NSString*)color{
  _color = color;
  [self setNeedsDisplay];
}

- (void)setShade:(NSString*)shade{
  _shade = shade;
}

- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
//- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
//- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];

  [roundedRect addClip];

  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);

  [[UIColor blackColor] setStroke];
  [roundedRect stroke];

//
//    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
//    if (faceImage) {
//      CGRect imageRect = CGRectInset(self.bounds,
//                                     self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
//                                     self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
//      [faceImage drawInRect:imageRect];
//    } else {
//      [self drawPips];
//    }
//
//    [self drawCorners];
}


- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;

}

- (void)awakeFromNib
{
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

@end
