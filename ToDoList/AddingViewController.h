//
//  AddingViewController.h
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *adding_Name;
@property (weak, nonatomic) IBOutlet UITextField *adding_desc;
@property NSMutableArray <Model *> *modelObj;
@property id<MyProtocol> p;
@property (weak, nonatomic) IBOutlet UISegmentedControl *piriority;
@property (nonatomic, strong) NSMutableArray *progress;



@end

NS_ASSUME_NONNULL_END
