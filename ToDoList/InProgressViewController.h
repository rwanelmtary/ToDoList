//
//  InProgressViewController.h
//  ToDoList
//
//  Created by rwan elmtary on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "MyProtocol.h"



NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MyProtocol>
@property NSMutableArray <Model*> *data;

@end

NS_ASSUME_NONNULL_END
