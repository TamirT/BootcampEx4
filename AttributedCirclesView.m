//
//  AttributedCirclesView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedCirclesView.h"
#import "AttributedShapesView.h"
#import "AttributedCircleView.h"

@interface AttributedCirclesView()

@property (strong, nonatomic) AttributedShapesView* drawer;


@end

@implementation AttributedCirclesView

-(instancetype)initWithProperties:(NSUInteger)instancesNum : (UIColor *)stroke : (UIColor *)fill{

  self = [super init];

  NSMutableArray *views = [[NSMutableArray alloc] init];

  for(NSUInteger i = 0 ; i < instancesNum ; i++){
    [views addObject:[[AttributedCircleView alloc] initWithColors:stroke :fill]];
  }
  self.drawer = [[AttributedShapesView alloc] initWithProperties:views];


  return self;
  
}

- (void)drawRect:(CGRect)rect{

  self.drawer.frame = rect;
  [self addSubview:self.drawer];
  [self.drawer setNeedsDisplay];

}


@end
