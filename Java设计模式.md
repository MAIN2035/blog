# Java设计模式

## 面向实现

### 状态模式

* 将代理对象在生命周期内从一个实现切换到另一种实现

```java
package cn;
//patterns/StateDemo.java //状态模式的简单演示
interface StateBase {
    void f();

    void g();

    void h();

    void changeImp(StateBase newImp);
}
/**
 * 多个操作类，多个代理类;
 * 一个共同接口一脉相承，中途变法自家兄弟*/
class State implements StateBase {
    private StateBase implementation;

    State(StateBase imp) {
        implementation = imp;//引用new Implementation1() new Implementation2()
    }

    @Override
    public void changeImp(StateBase newImp) {
        implementation = newImp;
    }
     @Override
    public void f() {
         implementation.f();
    }

    @Override
    public void g() {
        implementation.g();
    }

    public void h() {
        implementation.h();
    }
}

class Implementation1 implements StateBase {
    @Override
    public void f() {
        System.out.println("Implementation1.f()");
    }

    @Override
    public void g() {
        System.out.println("Implementation1.g()");
    }

    @Override
    public void h() {
        System.out.println("Implementation1.h()");
    }

    @Override
    public void changeImp(StateBase newImp) {
        //改变传入的参数，即改变private StateBase implementation字段的引用，以达到在代理对象的生命周期内从一个实现切换到另一种实现的目的
    }
}

class Implementation2 implements StateBase {
    @Override
    public void f() {
        System.out.println("Implementation2.f()");
    }

    @Override
    public void g() {
        System.out.println("Implementation2.g()");
    }

    @Override
    public void h() {
        System.out.println("Implementation2.h()");
    }

    @Override
    public void changeImp(StateBase newImp) {
    }
}

public class StateDemo {
    static void test(StateBase b) {
        b.f();
        b.g();
        b.h();
    }

    public static void main(String[] args) {
        StateBase b = new State(new Implementation1());
        test(b);
        b.changeImp(new Implementation2());//注意此时传入的对象
        test(b);
        b.changeImp(new Implementation1());
        test(b);
    }
}
/* Output:
Implementation1.f()
Implementation1.g()
Implementation1.h()
Implementation2.f()
Implementation2.g()
Implementation2.h()
Implementation1.f()
Implementation1.g()
Implementation1.h()
*/
```