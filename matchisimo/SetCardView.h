//
//  SetCardView.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 04/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardView.h"

@interface SetCardView : CardView
@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shade;
@property (nonatomic) BOOL chosen;

@end
