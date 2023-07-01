//
//  YLTheBasicListController.swift
//  YLNote
//
//  Created by tangh on 2023/6/29.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLTheBasicListController: YLBaseTableViewController {
    var father = YLFather()
    
    var son1 = YLSon()
    var son2 = YLSon()
    var unFather: UnsafeMutablePointer<YLFather>?
    weak var wkFather:YLFather?
    static var stFather:YLFather?
    var testArray:[AnyObject]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func fileName() -> String {
        return "BasicList"
    }

    /// 测试子类(caregory)+load方法
    func testSonLoad() {
        /**
         test 1: 子类实现load方法，父类不实现load
         打印：
         2020-07-18 15:19:44.620282+0800 TestDemo[52485:5573214] +[YLSon load]
         */
        
        /**
         test 2: 子类实现load方法，父类实现load 。
         结果打印:(先执行父类，后执行子类)
         2020-07-18 15:20:12.454908+0800 TestDemo[52502:5574051] +[YLFather load]
         2020-07-18 15:20:12.455673+0800 TestDemo[52502:5574051] +[YLSon load]
         */
        
        /**
         test 3: 子类不实现load方法，父类实现load
         打印：
         2020-07-18 15:20:54.070897+0800 TestDemo[52526:5575039] +[YLFather load]
         */
        
    }

    /**
     mathod 查找顺序：(分类的覆盖本类的，子类的覆盖父类的)
     1.查本类的方法列表 （包含 class_addMethod() + categoryMethodList + baseMethodList）
     2.查父类的方法列表
     
     */
    /// 子类是否实现Initalize方法
    func testSonInitalize() {
        /**
         test 1: 子类实现Initalize方法，父类不实现Initalize
         打印：
         2020-07-18 13:14:36.470353+0800 TestDemo[50448:5444966] +[YLSon initialize]
         */
        
        /**
         test 2: 子类实现Initalize方法，父类实现Initalize 。
         结果打印:(先执行父类，后执行子类)
         2020-07-18 13:10:23.949520+0800 TestDemo[50374:5440358] +[YLFather initialize]
         2020-07-18 13:10:23.949682+0800 TestDemo[50374:5440358] +[YLSon initialize]
         */
        
        /**
         test 3: 子类不实现Initalize方法，父类实现Initalize
         打印：(先执行父类，后执行子类（子类没有查到父类的实现）)
         2020-07-18 13:13:41.328426+0800 TestDemo[50424:5443668] +[YLFather initialize]
         2020-07-18 13:13:41.328591+0800 TestDemo[50424:5443668] +[YLFather initialize]
         */
        
//        [YLSon new];
        
    }

    func testSonOverwrite() {
        /**
         test 1: 子类实现hairColor方法，父类不实现hairColor
         打印：
         2020-07-18 16:43:10.566676+0800 TestDemo[53825:5669885] -[YLSon hairColor]: red
         */
        
        /**
         test 2: 子类实现hairColor方法，父类实现hairColor 。
         结果打印:(子类中查到方法，不在查父类)
         2020-07-18 16:44:29.183475+0800 TestDemo[53859:5671411] -[YLSon hairColor]: red
         */
        
        /**
         test 3: 子类不实现hairColor方法，父类实现hairColor
         打印：(子类种找不到方法，去父类找）)
         2020-07-18 16:45:52.614581+0800 TestDemo[53882:5672936] -[YLFather hairColor]: red
         */
        self.son1.hairColor();
        self.son2.hairColor();
    }
    /// 分类initalize方法
    func testCategoryInitalize() {
        /**
         test 1: 分类YLFather+Job实现Initalize方法，本类不实现Initalize
         打印：
         2020-07-18 14:02:16.611136+0800 TestDemo[51231:5496229] +[YLFather(Job) initialize]
         */
        
        /**
         test 2: 分类实现Initalize方法，本类实现Initalize 。
         结果打印:
         2020-07-18 14:09:52.259161+0800 TestDemo[51337:5503903] +[YLFather(Job) initialize]
         */
        
        /**
         test 3: 分类不实现Initalize方法，本类实现Initalize
         2020-07-18 14:11:23.054112+0800 TestDemo[51387:5506117] +[YLFather initialize]
         打印：
         */
        let _ = YLFather();
//        [YLFather new];
    }

    /// 测试原类方法被覆盖（查找原理同Initialize，区别：实例方法从本类列表中查找，类方法从元类列表中查找）
    func testCategoryOverwrite() {
        let gender = self.father.gender();
        print("性别：\(gender)");
    }

    /// 测试分类添加属性，是否会添加d实例变量
    func testCategory_associate_ivas() {
        
        self.father.job = "教师";
        //    [self.father setJob:"中国"];
            var outCount:UInt32 = 0;
        /**
         *  通过传入一个类,获取这个类所有的实例变量
         *  第一个参数 : 传入一个类
         *  第二个参数 : 传入一个地址,返回一个 Int 型的值到这个地址
         *  返回一个包含所有实例变量的指针
         */
         
        let ivars:UnsafeMutablePointer<objc_property_t>! =  class_copyMethodList(type(of: self.father), &outCount)
            let count = Int(outCount)
            
        for i in 0..<count {
            let ivar = ivars[i];
            print("实例变量:",ivar_getName(ivar), ivar_getTypeEncoding(ivar),ivar_getOffset(ivar));

        }
        
        print("工作: \(self.father.job)");
    }

    /// 测试分类添加属性，是否会添加proterty
    func testCategory_associate_protertys() {
        var outCount:UInt32 = 0;
        var properties:UnsafeMutablePointer<objc_property_t>! = class_copyPropertyList(type(of: self.father), &outCount);
        let count = Int(outCount)
        for i in 0..<count {
            let property = properties[i];
            //属性名
            let name = property_getName(property);
            //属性描述
            let propertyAttr = property_getAttributes(property);
            print("属性- Attributes：【%s】，名称： %s ", propertyAttr, name);
            
            //属性的特性
            //           var attrCount = 0;
            //           objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
            //           for (var j = 0; j < attrCount; j ++) {
            //               objc_property_attribute_t attr = attrs[j];
            //               const char * name = attr.name;
            //               const char * value = attr.value;
            //               print("属性的描述：%s 值：%s", name, value);
            //           }
            //           free(attrs);
            print("\n");
        }
        
        print("properties地址:",properties);
        free(properties); // c代码需要手动管理内存，释放。否则会内存泄漏
    }

    // 获取所有实例方法
    func testCategory_associate_methds() {
        var outCount:UInt32 = 0;
        var methodlist:UnsafeMutablePointer<Method>! = class_copyMethodList(type(of: self.father), &outCount);
        let count = Int(outCount)
        for i in 0..<count {
            let method = methodlist[i];
            let name = method_getName(method);
            let type = method_getTypeEncoding(method);
            print("方法名：%s 类型： %s ", sel_getName(name),type);
            
        }
        
        free(methodlist);
    }

    /// 获取所有类方法
    func testCategory_associate_class_methds() {
        var outCount:UInt32 = 0;
        var methodlist:UnsafeMutablePointer<Method>! = class_copyMethodList(type(of: self.father), &outCount);
        let count = Int(outCount)
        for i in 0..<count {
            let method = methodlist[i];
            let name = method_getName(method);
            let type = method_getTypeEncoding(method);
            print("方法名：", sel_getName(name),type);
            
        }
        
        free(methodlist);
    }

    func testClassMethod() {
//        YLFather.performSelector(#selector(testTest));
    }

    func testMsg_resolve() {
        self.son1.eat();
    }

    func testMsg_forwarding() {
        self.son1.eat();
    }

//    - (instancetype)initWithDict:(let )dict() {
//
//        if (self = [self init]) {
//            //(1)获取类的属性及属性对应的类型
//            NSMutableArray * keys = [NSMutableArray array];
//            NSMutableArray * attributes = [NSMutableArray array];
//            /*
//             * 例子
//             * name = value3 attribute = T"NSString",C,N,V_value3
//             * name = value4 attribute = T^i,N,V_value4
//             */
//            var outCount;
//            var properties = class_copyPropertyList([self class], &outCount);
//            for (int i = 0; i < outCount; i ++) {
//                objc_property_t property = properties[i];
//                //通过property_getName函数获得属性的名字
//                let  propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//                [keys addObject:propertyName];
//                //通过property_getAttributes函数可以获得属性的名字和@encode编码
//                let  propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//                [attributes addObject:propertyAttribute];
//            }
//            //立即释放properties指向的内存
//            free(properties);
//
//            //(2)根据类型给属性赋值
//            for (let  key in keys) {
//                if ([dict valueForKey:key] == nil) continue;
//                [self setValue:[dict valueForKey:key] forKey:key];
//            }
//        }
//        return self;
//
//    }
    // MARK: - 内存泄漏
    /// 内存泄漏（A、B互相持有，无法打破循环引用）
    func testMemory() {
       do {
            let test0 = YLFather(); //A对象
            let test1 = YLFather();//B对象
            
            //此时B对象的持有者为test1 和 A对象的成员变量obj，B对象被两条强指针指向
            test0.propertyObj1 = test1;
            
            //此时A对象的持有者为test0 和 B对象的成员变量obj，A对象被两条强指针指向
            test1.propertyObj1 = test0;
        }
        /*
         test0 超出其作用域 ，所以其强引用失效，自动释放对象A;
         test1 超出其作用域 ，所以其强引用失效，自定释放对象B;
         
         此时持有象A的强引用的变量为B对象的成员变量obj；
         此时持有对象B的强引用的变量为A对象的成员变量obj;
         
         因为都还被一条强指针指向，所以内存泄漏！
         */
    }


    // MARK: - 关键字
    /// 测试copy关键字
    func testCopy() {
        
        var t1 = ["hello","world"];
        self.testArray = t1 as [AnyObject]; // testArray设置器里的copy执行的是浅copy (入参是不可变类型)
        
        t1 = ["ldldlld"];
        print("1:",t1,self.testArray);
        
        let mT1 = NSMutableArray();
        self.testArray = mT1 as [AnyObject]; // testArray设置器里的copy执行的是深copy (入参是可变类型)
        print("2: %p--%p",mT1,self.testArray);
    }

    /// weak
    func testWeak() {
        do {
            self.wkFather = YLFather();
            print("局部即将退出: \(self.wkFather)");
        }
        print("局部已退出: \(self.wkFather)");
    }

    func test_unsafe_unretained() {
        do {
//            self.unFather = YLFather();
//            print("局部即将退出: \(self.unFather)");
            let size = MemoryLayout<YLFather>.stride
            self.unFather = UnsafeMutablePointer<YLFather>.allocate(capacity: size)
            // 在 unsafeProperty 中写入值
            self.unFather?.initialize(to: YLFather())

        }
        print("局部已退出: \(self.unFather)");
    }

    func testStrong() {
        do {
            self.father = YLFather();
            print("局部即将退出: \(self.father)");
        }
        print("局部已退出: \(self.father)");
    }

    /// 测试__weak、__strong、__unsafe_unretained 关键字
    func testWeak_strong__unsafe_unretained() {
        // 告知编译器忽略未使用变量警告⚠️
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wunused-variable"
//        __strong let strongZYClass;
//        __weak let weakZYClass;
//        __unsafe_unretained let unsafeZYClass;
//    #pragma clang diagnostic pop
//
//        print("test begin");
//
//        {
//            let zyClass = YLFather();
//            //        strongZYClass = zyClass;
//            weakZYClass = zyClass;
//            //        unsafeZYClass = zyClass;
//            print("局部退出%@--\(zyClass,weakZYClass);
//        }
//
//        print("test over\(weakZYClass);
    }


//    func testAutorelease() {
//        let autoVC = YLTestAutoReleaseController();
//        self.navigationController?.pushViewController(autoVC, animated: true)
//    }
//
//    // MARK: - KVO
//    func testIsa_swizzing() {
//        let kvoVC = YLKVOViewController();
//      self.navigationController?.pushViewController(kvoVC, animated: true);
//        
//    }
//
//    // MARK: - YLNotifiTestViewController
//
//    func testNotification() {
//        let vc = YLDemoNotifiViewController();
//      self.navigationController?.pushViewController(vc, animated: true);
//    }
//
//    func testNotification_block() {
//        let vc = YLNotificationTestViewController();
//      self.navigationController?.pushViewController(vc, animated: true);
//    }
    // MARK: - Foundation
    // nil、NILL、NSNULL区别
    func test_nilAndNSNull() {
        let msg = "nil、NIL 可以说是等价的，都代表内存中一块空地址。\n NSNULL 代表一个指向 nil 的对象。"
        YLAlertManager.showAlert(withTitle: "nil、NILL、NSNULL", message: msg, actionTitle: "oK")
    }

    /**
     相同点:
    instancetype 和 id 都是万能指针，指向对象。
    不同点：
    1.id 在编译的时候不能判断对象的真实类型，instancetype 在编译的时候可以判断对象的真实类型。
    2.id 可以用来定义变量，可以作为返回值类型，可以作为形参类型；instancetype 只能作为返回值类型。
     */
    func test_idAndInstancetype() {
        let msg = " 相同点:instancetype 和 id 都是万能指针，指向对象。\n不同点： 1.id 在编译的时候不能判断对象的真实类型，instancetype 在编译的时候可以判断对象的真实类型。\n    2.id 可以用来定义变量，可以作为返回值类型，可以作为形参类型；instancetype 只能作为返回值类型";
        YLAlertManager.showAlert(withTitle: "id & instancetype", message: msg, actionTitle: "oK")
    }

    /// self和super的区别
    func test_selfAndSuper() {
        let plumDict = YLFileManager.jsonParse(withLocalFileName: "TRex")
        let TRex = YLDinodsaul.yy_model(with: plumDict as! [AnyHashable : Any]);
        TRex?.testClass();
    }
    /**
     类： 引用类型（位于栈上面的指针（引用）和位于堆上的实体对象）
     结构体：值类型（实例直接位于栈中）
     */
    // struct和class的区别
    func test_structAndClass() {
        let msg = "类： 引用类型（位于栈上面的指针（引用）和位于堆上的实体对象）\n结构体：值类型（实例直接位于栈中）";
        YLAlertManager.showAlert(withTitle: "值类型&引用类型", message: msg, actionTitle: "oK")

    }

    // MARK: - UIkit
    /**
     因为UIView依赖于CALayer提供的内容，而CALayer又依赖于UIView提供的容器来显示绘制的内容，所以UIView的显示可以说是CALayer要显示绘制的图形。当要显示时，CALayer会准备好一个CGContextRef(图形上下文)，然后调用它的delegate(这里就是UIView)的drawLayer:inContext:方法，并且传入已经准备好的CGContextRef对象，在drawLayer:inContext:方法中UIView又会调用自己的drawRect:方法。
         我们可以把UIView的显示比作“在电脑上使用播放器播放U盘上得电影”，播放器相当于UIView，视频解码器相当于CALayer，U盘相当于CGContextRef，电影相当于绘制的图形信息。不同的图形上下文可以想象成不同接口的U盘

     注意：当我们需要绘图到根层上时，一般在drawRect:方法中绘制，不建议在drawLayer:inContext:方法中绘图

     */
    func test_displayUIView() {
        YLAlertManager.showAlert(withTitle: "值类型&引用类型", message: " 因为UIView依赖于CALayer提供的内容，而CALayer又依赖于UIView提供的容器来显示绘制的内容，所以UIView的显示可以说是CALayer要显示绘制的图形。当要显示时，CALayer会准备好一个CGContextRef(图形上下文)，然后调用它的delegate(这里就是UIView)的drawLayer:inContext:方法，并且传入已经准备好的CGContextRef对象，在drawLayer:inContext:方法中UIView又会调用自己的drawRect:方法。", actionTitle: "oK")
    }

    // MARK: - datasource Protocol
    //func doFunctionWith:(let )name parameter:(id)parameter() {
    //    let funcName = [NSString stringWithFormat:"test_\(name];
    //    SEL selector = NSSelectorFromString(funcName);
    //
    //    //检查是否有"myMethod"这个名称的方法
    //    if ([self respondsToSelector:selector]) {
    //        if (!self) { return; }
    //        if ([name containsString:":"]) {
    //            IMP imp = [self methodForSelector:selector];
    //            CGRect (*func)(id, SEL, id, id) = (void *)imp;
    //            CGRect result = self ?
    //            func(self, selector, "2", "3") : CGRectZero;
    //            print("result:: \(NSStringFromCGRect(result));
    //        } else {
    //            IMP imp = [self methodForSelector:selector];
    //            void (*func)(id, SEL) = (void *)imp;
    //            func(self, selector);
    //        }
    //    }
    //
    //
    //}

}
