//
//  AttributedRectsView.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "AttributedRectsView.h"
#import "AttributedShapesView.h"
#import "AttributedRectView.h"

@interface AttributedRectsView()

@property (strong, nonatomic) AttributedShapesView* drawer;


@end

@implementation AttributedRectsView

-(instancetype)initWithProperties:(NSUInteger)instancesNum : (UIColor *)stroke : (UIColor *)fill{

  self = [super init];
  NSMutableArray *views = [[NSMutableArray alloc] init];

  for(NSUInteger i = 0 ; i < instancesNum ; i++){
    [views addObject:[[AttributedRectView alloc] initWithColors:stroke :fill]];
  }
  self.drawer = [[AttributedShapesView alloc] initWithProperties:views];


  return self;
  
}

-(void)drawRect:(CGRect)rect{

  self.drawer.frame = rect;
  [self addSubview:self.drawer];
  [self.drawer setNeedsDisplay];
}



@end
