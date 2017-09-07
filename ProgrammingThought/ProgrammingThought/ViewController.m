//
//  ViewController.m
//  ProgrammingThought
//
//  Created by Yochi·Kung on 2017/8/6.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"
#import "Person.h"
#import "NSObject+CustomKVO.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** 编程思想 */
    [self programingThough];
    
    /** 自定义KVO */
    [self customKVO];
}

- (void)programingThough
{
    Person *person = [[Person alloc] init];
    /** 普通的调用方式 只能单个调用 */
    [person eat];
    [person sleep];
    
    /** 链式写法 */
    [[person eat1] sleep1];
    [[person sleep1] eat1];
    [[person eat1] eat1];
    
    /** 我们一般通过”点”语法，将需要执行的代码块连续的书写下去,就是链式编程.它能使代码简单易读，书写方便 */
    NSLog(@"%@",person.eat1.sleep1.eat1.sleep1.sleep1);
    
    /** 将bock作为返回值 */
    person.sleep2();
    person.eat2();
    
    /** 带参数 返回调用者本身即可*/
    person.sleep3(@"床").eat3(@"苹果").eat3(@"香蕉").sleep3(@"沙发");
    
    /** 函数编程写法 */
    
    //函数式编程思想:是将操作尽可能写在一起!嵌套的函数!!
    //本质:就是往方法里面传入Block,方法中嵌套Block调用.
    Person *calculatPerson = [person calculator:^NSInteger(NSInteger result) {
        
        result = result + 10;
        result = result*10;
        return result;
    }];
    
    NSLog(@"%ld", calculatPerson.result);
    
    /** 链式 + 函数式编程实现加法 */
    
    /** 链式 + 函数编程 典型案例 */
    UIView * redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //链式编程思想特点:方法返回值必须要有方法调用者!!
    
    //添加约束  --  make约束制造者!!
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置约束 每次调用left\top就是将约束添加到数组中!
        /*
         MASConstraint * (^block)(id)  = make.left.top.equalTo;
         MASConstraint * mk = block(@10);
         mk.top;
         */
        make.left.top.equalTo(@20);
        
        make.right.bottom.equalTo(@-10);
        /**
         mas_makeConstraints执行流程:
         1.创建约束制造者MASConstraintMaker,并且绑定控件,生成一个保存所有约束的数组
         2.执行mas_makeConstraints传入的Block
         3.让约束制造者安装约束!
         * 1.清空之前的所有约束
         * 2.遍历约束数组,一个一个安装
         */
    }];
    
    /** 函数链式编程仿写 */
    [person makecalculator:^(addCalculator *addcalculator) {
        
        addcalculator.add(10).add(30);
    }];
    
    NSLog(@"person : %ld", person.result);
    
    /** 响应式编程KVO */
    [_p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    /* RACSignal: 信号类,当我们有数据产生,创建一个信号! **/
    
    /** 1.创建信号(冷信号!) */
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        /** 3.发送数据subscriber它来发送 */
        [subscriber sendNext:@"呵呵哈哈嘿嘿"];
        
        return nil;
    }];
    
    /** 2.订阅信号(热信号!!) */
    [signal subscribeNext:^(id x) {
        
        /** x:信号发送的内容!! */
        NSLog(@"%@",x);
    }];
}

/** KVO 响应方法 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", _p.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    i++;
    //_p.name = [NSString stringWithFormat:@"Yochi不高兴 %d", i];
    _p.age  = [NSString stringWithFormat:@"%d岁的Yochi很帅",i];
    // _p->_name  = [NSString stringWithFormat:@"Yochi不高兴 %d", i];
    
    //NSLog(@"_p.name : %@", _p.name);
}

/**********************************************/

/** 自定义KVO */
- (void)customKVO
{
    Person *person = [[Person alloc] init];
    _p = person;
    
    [_p yochi_addObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
{
    NSLog(@"keyPath : %@ object : %@", keyPath,object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
