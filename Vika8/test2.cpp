#include <iostream>
using namespace std;

class Base {
private:
    int privateVar;
protected:
    int protectedVar;
public:
    int publicVar;
    Base() : privateVar(1), protectedVar(2), publicVar(3) {}
    void showBase() {
        cout << "Base: " << privateVar << ", " 
             << protectedVar << ", " << publicVar << endl;
    }
};

class Derived : public Base {
public:
    void showDerived() {
        // The following line would cause a compile error because
        // 'privateVar' is a private member of Base and is inaccessible here.
        // cout << "Private: " << privateVar << endl;

        cout << "Protected: " << protectedVar << endl;
        cout << "Public: " << publicVar << endl;
    }
};

int main() {
    Base b;
    Derived d;
    
    // The following line would cause a compile error because
    // 'protectedVar' is not accessible outside the class hierarchy.
    // cout << b.protectedVar << endl;
    
    cout << "Public: " << b.publicVar << endl;
    d.showDerived();
    
    return 0;
}


