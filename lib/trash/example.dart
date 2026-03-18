mixin HasName {
    String name = "some";
}

mixin HasLegs {
    bool hasLegs = true;
}

mixin CanWalk on HasName, HasLegs {
    void walk() {
        print("$name is walking");
    }
}

class Human with HasName, HasLegs, CanWalk {
    @override
    String name = "Human";
}

void main() {
    print("Hi!");
    Human().walk();
}