#include <iostream>
#include <string>
using namespace std;


class Vehicle {
    public:
        string make;
        string model;
    
        Vehicle(string make, string model) {
            this->make = make;
            this->model = model;
        }
    
        virtual string move() {
            return "Move!";
        }
    
        string str() {
            return make + " " + model;
        }

};

class Car : public Vehicle {
public:
    Car(string make, string model) : Vehicle(make, model){
    }

    string move() {
        return "Drive!";
    }
};

class Boat : public Vehicle {
public:
    Boat(string make, string model) : Vehicle(make, model){
    }
    
    string move() {
        return "Sail!";
    }
};

class Plane : public Vehicle {
public:
    Plane(string make, string model) : Vehicle(make, model){
    }
    
    string move() {
        return "Fly!";
    }
};


int main() {
    Vehicle vehicle("Generic", "Vehicle");
    Car car("Ford", "Mustang");
    Boat boat("Ibiza", "Touring 20");
    Plane plane("Boeing", "747");
    Vehicle* vehicles[] = {&vehicle, &car, &boat, &plane};
    for (int i = 0; i < 4; i++) {
        cout << vehicles[i]->str() << " " << vehicles[i]->move()<< endl;
    }
    return 0;
}