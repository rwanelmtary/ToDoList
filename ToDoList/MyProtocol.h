//
//  MyProtocol.h
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>

-(void) reload:(Model*)m;

@end

NS_ASSUME_NONNULL_END
