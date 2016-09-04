//
//  CardProtocol.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 31/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#ifndef CardProtocol_h
#define CardProtocol_h
#import "Card.h"

@protocol CardViewProtocol : UIView

-(void)setCardView:(Card *)card;

@property (nonatomic)CGPoint positionInGrid;

@end

#endif /* CardProtocol_h */
