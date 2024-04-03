//
//  DetailsViewController.h
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *details_Name;
@property (weak, nonatomic) IBOutlet UITextField *details_Desc;
@property  Model* modelObject;
@property (weak, nonatomic) IBOutlet UITextField *currentTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *details_piriority;
@property NSMutableArray *progresArr;
@property NSMutableArray *doneArr;


@end

NS_ASSUME_NONNULL_END
