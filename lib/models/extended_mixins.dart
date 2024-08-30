abstract class SharedProperties {
  // Constructor to initialize properties
  SharedProperties(this.value);

  final int value;

  void printValue() {
    print('Value: $value');
  }
}

mixin ExtraFunctionality on SharedProperties {
  void doSomething() {
    print('Value from mixin: $value');
    print('Doing something extra!');
  }
}

class MyCombinedClass extends SharedProperties with ExtraFunctionality {
  // Constructor that initializes the properties of the abstract class
  MyCombinedClass(int value) : super(value);

  @override
  void printValue() {
    super.printValue(); // Calls the method from SharedProperties
    print('MyCombinedClass Value: $value');
  }
}
