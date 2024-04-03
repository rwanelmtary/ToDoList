//
//  ViewController.h
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "MyProtocol.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MyProtocol ,UISearchBarDelegate>
@property NSMutableArray <Model*> *data;


@end

