//
//  OORunTimeController.m
//  BaseFramework
//
//  Created by Beelin on 16/12/15.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OORunTimeController.h"
#import <objc/runtime.h>
#import "Person.h"

#import "Cat.h"
#import "Dog.h"
#import "Chicken.h"
@interface OORunTimeController ()

@end

@implementation OORunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self metaClass];
    
    //    Cat *cat = [[Cat alloc] init];
    //    [cat jump];
    //
    //    Dog *dog = [[Dog alloc] init];
    //    [dog jump];
    //
    //    Chicken *chicken = [[Chicken alloc] init];
    //    [chicken jump];
    NSLog(@"slef.class : %@",self.class);
    NSLog(@"super.class : %@",super.class);
}
- (void)method1
{
    NSLog(@"run method1");
}

- (void)method2
{
    NSLog(@"run method2");
}
- (void)createClass
{
    
    Class cls = objc_allocateClassPair([NSObject class], "Prson", 0);
    
    //获取函数指针
    IMP method = class_getMethodImplementation([self class], @selector(method1));
    
    //动态添加方法
    class_addMethod(cls, @selector(method1), method, "v@:");
    
    //动态替换方法
    class_replaceMethod(cls, @selector(method2), method, "v@:");
    
    //动态添加成员变量  添加一个NSString的变量，第四个参数是对其方式，第五个参数是参数类型
    class_addIvar(cls, "name", sizeof(NSString *), log(sizeof(NSString *)), "@");
    
    //注册
    objc_registerClassPair(cls);
    
    
    //实例
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(method2)];
    
    //赋值成员变量
    NSString *str = @"123";
    //	object_setInstanceVariable(myobj, "itest", (void *)&str);在ARC下不允许使用
    [instance setValue:str forKey:@"name"];
    
    //获取成员变量
    Ivar var = class_getInstanceVariable(cls, "name");
    id o = object_getIvar(instance, var);
    NSLog(@"%@",o);
    
    
    
    
}
- (void)get
{
    Person *person = [[Person alloc] init];
    
    //获取类名
    const char *className = object_getClassName(person);//class_getName([person class])
    NSLog(@"%s",className);
    
    //获取父类
    Class c = class_getSuperclass([person class]);
    NSLog(@"%@",NSStringFromClass([c class]));
    
    //获取元类
    Class metaClass = objc_getMetaClass(class_getName([person class]));
    NSLog(@"%@",NSStringFromClass([metaClass class]));
    
    //判断给定的Class是否是一个元类
    bool b = class_isMetaClass([person class]);
    NSLog(@"%d",b);
    
    // 获取实例大小
    size_t size = class_getInstanceSize ([person class]);
    NSLog(@"%zu",size);
    
    //获取属性
    objc_property_t property = class_getProperty([person class], "name");
    const char *propertyName = property_getName(property);
    NSLog(@"%s",propertyName);
    
    
}

#pragma mark - Ivar
/** 获取所有成员变量 */
- (void)getAllIvar
{
    //  Person *person = [[Person alloc] init];
    
    unsigned int count = 0;
    Ivar  *vars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i ++) {
        //获取成员变量名
        const char *varName = ivar_getName(vars[i]);
        //获取成员变量类型
        const char *varType = ivar_getTypeEncoding(vars[i]);
        NSLog(@"%s",varName);
        NSLog(@"%s",varType);
    }
    free(vars);
}

/** 动态添加成员变量  修改成员变量值*/
- (void)addIvar
{
    Class cls = objc_allocateClassPair([NSObject class], "myPerson", 0);
    //动态添加成员变量
    class_addIvar(cls, "name", sizeof(NSString *), log(sizeof(NSString *)), "@");
    
    //注册
    objc_registerClassPair(cls);
    
    id person = [[cls alloc] init];
    
    
    //获取成员变量
    Ivar var = class_getInstanceVariable(cls, "name");
    //获取成员变量名
    const char *ivarName = ivar_getName(var);
    NSLog(@"ivarName: %s",ivarName);
    //获取成员变量类型
    const char *ivarType = ivar_getTypeEncoding(var);
    NSLog(@"ivarName: %s",ivarType);
    
    //赋值成员变量
    object_setIvar(person, var, @"Gatlin");
    //获取成员变量值
    id o = object_getIvar(person, var);
    NSLog(@"o: %@",o);
}

#pragma mark - Property
/** 获取所有属性 */
- (void)getAllProperties
{
    Person *person = [[Person alloc] init];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    
    for (int i = 0; i < count; i ++) {
        const char *properyName = property_getName(properties[i]);
        
        NSLog(@"%s",properyName);
        
        //获取属性
        //objc_property_t property = class_getProperty(cls, "name");
        //获取属性名
        const char *propertyName = property_getName(properties[i]);
        NSLog(@"propertyName: %s",propertyName);
        const char *propertyAttributes = property_getAttributes(properties[i]);
        NSLog(@"const char *propertyName: %s",propertyAttributes);
    }
    
    free(properties);
    
    //修改属性值，须获取成员变量来修改
    Ivar ivar = class_getInstanceVariable([Person class], "_name");
    object_setIvar(person, ivar, @"Gatlin");
    id o = object_getIvar(person, ivar);
    NSLog(@"o:%@",o);
}

/** 动态添加属性 */
- (void)addProperty
{
    //动态创建类
    Class cls = objc_allocateClassPair([NSObject class], "myPerson", 0);
    
    /*设置属性的特性
     属性类型  name值：T  value：变化
     编码类型  name值：C(copy) &(strong) W(weak) 空(assign) 等 value：无
     非/原子性 name值：空(atomic) N(Nonatomic)  value：无
     变量名称  name值：V  value：变化
     */
    objc_property_attribute_t type = {"T","@\"NSString\""}; //类型
    objc_property_attribute_t ownership = {"C",""};  //copy
    objc_property_attribute_t backingIvar = {"V","_name"}; //设置私有成员变量名
    
    objc_property_attribute_t array[] = {type, ownership, backingIvar};
    class_addProperty(cls, "name", array, 3);
    
    
    //注册
    objc_registerClassPair(cls);
    
    //获取属性
    objc_property_t property = class_getProperty(cls, "name");
    
    //获取属性名
    const char *propertyName = property_getName(property);
    NSLog(@"propertyName: %s",propertyName);
    
    //获取属性特性描述字符串
    const char *propertyAttributes = property_getAttributes(property);
    NSLog(@"propertyAttributes: %s",propertyAttributes);
    
    //获取属性中指定的特性
    char *propertyAttributeValues = property_copyAttributeValue(property, "T");
    NSLog(@"propertyAttributeValues: %s",propertyAttributeValues);
    free(propertyAttributeValues);
    
    // 获取属性的特性列表
    unsigned int count = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &count);
    for (int i = 0; i < count; i ++) {
        NSLog(@"attribute.name: %s,attributes.value: %s",attributes[i].name,attributes[i].value);
    }
    free(attributes);
    
}


#pragma mark - Method
/**
 *  获取一个类的所有方法
 获取包含类方法 需要传入元类
 */
- (void)getMethodList
{
    Person *person = [[Person alloc] init];
    
    //获取person的元类
    Class metaClass = objc_getMetaClass(class_getName([person class]));
    
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        // 取出对应的方法
        Method method = methodList[i];
        
        // 获取方法名(方法编号)
        SEL methodSel =  method_getName(method);
        
        NSLog(@"%@",NSStringFromSelector(methodSel));
        
        
    }
    
    free(methodList);
}

/** 动态添加方法 */
- (void)addMethod
{
    Class cls = objc_allocateClassPair([NSObject class], "myPerson", 0);
    
    //动态添加方法
    SEL sel = @selector(method1);
    IMP imp = class_getMethodImplementation([self class], sel);
    class_addMethod(cls, sel, imp, "v@:");
    
    //注册
    objc_registerClassPair(cls);
    
    //实例对像
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(method1)];
    
    
    //获取实例方法
    Method method = class_getInstanceMethod(cls, sel);
    //获取方法名
    SEL selName = method_getName(method);
    NSLog(@"selName: %@",NSStringFromSelector(selName));
    //获取方法实现
    IMP imp1 = method_getImplementation(method);
    
    // 获取方法的返回值类型的字符串
    const char *type = method_copyReturnType(method);
    NSLog(@"type: %s",type);
    
    // 获取描述方法参数和返回值类型的字符串
    const char *typeEncoding = method_getTypeEncoding (method);
    NSLog(@"typeEncoding: %s",typeEncoding);
}


#pragma mark - Protocol
- (void)getProtocol
{
    
    // 获取运行时所知道的所有协议的数组
    
    //    Protocol  *protocolList = class_copyProtocolList([Person class], &count);
    //
    //    for (int i = 0; i < count; i ++) {
    //        const char *name = protocol_getName(protocolList);
    //        NSLog(@"protocolName: %s",name);
    //    }
}

- (void)addProtocol
{
    
    
    // 创建新的协议实例
    Protocol *protocol = objc_allocateProtocol ("PersonDelegate");
    
    // 在运行时中注册新创建的协议
    objc_registerProtocol(protocol);
    
    
    const char *protocolName = protocol_getName(protocol);
    NSLog(@"protocolName : %s",protocolName);
    
}


#pragma mark - Block
- (void)setBlock
{
    IMP imp = imp_implementationWithBlock(^(id obj, NSString *str){
        
        NSLog(@"%@",str);
    });
    
    class_addMethod([Person class], @selector(testBlock:), imp, "v@:@");
    
    
    Person *per = [[Person alloc] init];
    [per performSelector:@selector(testBlock:) withObject:@"hello world!"];
    
}

#pragma mark - MetaClass
- (void)metaClass
{
    NSArray *arr = [NSArray array];
    Class cls = [arr class];
    int i = 0;
    
    while (1) {
        NSLog(@"%d---clsName:%@---cls:%p---nsobject:%p", i, NSStringFromClass([cls class]), cls, objc_getMetaClass("NSObject"));
        
        i++;
        if (cls == objc_getMetaClass("NSObject")) break;
        
        cls = object_getClass(cls);
    }
}
@end

