//
//  DoneViewController.h
//  ToDoList
//
//  Created by rwan elmtary on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray <Model*> *data;

@end

NS_ASSUME_NONNULL_END
