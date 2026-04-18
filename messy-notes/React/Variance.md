Here's a practical, example-driven explanation of covariance and contravariance in TypeScript.

## The Simple Rule (Remember This!)

**Covariance** = You can use a **more specific** type where a **less specific** type is expected (outgoing/read position)

**Contravariance** = You can use a **less specific** type where a **more specific** type is expected (incoming/write position)

## 🟢 Covariance (Output/Read)

Covariance is about **returning/producing** values. A function return type is **covariant** — you can return a subtype.

```typescript
class Animal {
  name: string = 'Animal';
}
class Dog extends Animal {
  bark(): void {}
}
class Poodle extends Dog {
  groom(): void {}
}

// A function that returns Dog
const getDog = (): Dog => new Dog();

// ✅ Covariance works: Poodle is a subtype of Dog
const getPoodle: () => Dog = (): Poodle => new Poodle();

// This also works:
const animals: Animal[] = [new Dog(), new Poodle()]; // Dog and Poodle are Animals
```

**Arrays are covariant** in TypeScript (which can be unsafe):

```typescript
const dogs: Dog[] = [new Dog(), new Poodle()]; // ✅ Poodle is a Dog
const animals: Animal[] = dogs; // ✅ Dogs are Animals

// ⚠️ This is why covariance can be unsafe:
animals.push(new Animal()); // Runtime error! animals is really dogs array
```

## 🔴 Contravariance (Input/Write)

Contravariance is about **accepting/consuming** values. Function parameters are **contravariant** — you can accept a supertype.

```typescript
// A function that processes a Dog
const processDog = (dog: Dog): void => {
  console.log(dog.name);
};

// ✅ Contravariance works: Animal is a supertype of Dog
const processAnimal: (dog: Dog) => void = (animal: Animal) => {
  console.log(animal.name);
};

// This would FAIL (can't accept subtype):
// const processPoodle: (dog: Dog) => void = (poodle: Poodle) => {
//     poodle.groom(); // ⚠️ What if we get a Dog without groom()?
// };
```

## 📊 The Classic Function Example

This is the most important example to understand:

```typescript
type AnimalHandler = (animal: Animal) => Animal;

type DogHandler = (dog: Dog) => Dog;

// Function parameters are CONTRAvariant (you can pass wider type)
// Function return types are COvariant (you can return narrower type)

// ✅ A DogHandler can be assigned where AnimalHandler is expected?
const animalHandler: AnimalHandler = (animal: Animal): Animal => animal;

const dogHandler: DogHandler = (dog: Dog): Dog => dog;

// This works because:
// - Parameter: DogHandler accepts Dog, AnimalHandler accepts Animal (wider)
//   But contravariance means: AnimalHandler can take Dog (since Dog is Animal)
// - Return: DogHandler returns Dog, AnimalHandler returns Animal (wider)
//   Covariance means: returning Dog is fine where Animal is expected

// Actually, TypeScript allows this:
const works: DogHandler = animalHandler; // ✅
const alsoWorks: AnimalHandler = dogHandler; // ✅ (but with constraints)
```

## 🎯 The `Function` Parameter Rule (Most Important!)

When assigning functions, **parameters are checked contravariantly** in TypeScript's strict mode:

```typescript
type ExpectsDog = (dog: Dog) => void;
type ExpectsAnimal = (animal: Animal) => void;

let f: ExpectsDog = (dog: Dog) => {
  dog.bark();
};
let g: ExpectsAnimal = (animal: Animal) => {
  console.log(animal.name);
};

// ✅ Contravariance: ExpectsDog can accept ExpectsAnimal
// Because a function expecting Animal can handle Dog (Dog is Animal)
f = g;

// ❌ This would fail (if uncommented):
// g = f; // f expects Dog with bark(), but animal may not have bark()
```

**The mental model:**

- **Return type**: Can be **narrower** (subtype) → Covariant
- **Parameter type**: Can be **wider** (supertype) → Contravariant

## 🔧 Practical Real-World Examples

### Example 1: Event Handlers

```typescript
interface UIEvent {
  timestamp: number;
}
interface ClickEvent extends UIEvent {
  x: number;
  y: number;
}
interface SubmitEvent extends UIEvent {
  formData: FormData;
}

// Handler that can handle ANY UIEvent
type UIHandler = (event: UIEvent) => void;

// Handler that specifically handles ClickEvent
type ClickHandler = (event: ClickEvent) => void;

// ✅ Contravariance: You can use a UIHandler where a ClickHandler is expected
const logAllEvents: UIHandler = (e) => console.log(e.timestamp);
const handleClick: ClickHandler = logAllEvents; // ✅ Works!
```

### Example 2: Predicate Functions

```typescript
// A filter that accepts any Animal
const isMammal = (animal: Animal): boolean => animal.name !== 'fish';

// A filter for Dogs specifically
const isLargeDog = (dog: Dog): boolean => dog.name.length > 5;

// ✅ Covariance in return type, contravariance in parameter
const animals: Animal[] = [new Dog(), new Animal()];
const dogs: Dog[] = animals.filter(isMammal); // ✅ Works
```

### Example 3: React/UI Component Props

```typescript
interface Props {
    onChange: (value: string | number) => void;  // Wide parameter
}

// Child component with more specific onChange
interface ChildProps {
    onChange: (value: string) => void;  // Narrower parameter
}

// ✅ This works due to contravariance
const Child: React.FC<ChildProps> = ({ onChange }) => {
    return <input onChange={(e) => onChange(e.target.value)} />;
};

// Parent can pass wider handler to child expecting narrower
const Parent = () => {
    const handleChange = (value: string | number) => { /* ... */ };
    return <Child onChange={handleChange} />; // ✅ Works!
};
```

## 📝 Quick Reference Table

| Context              | Variance                 | Meaning                      | Example                              |
| -------------------- | ------------------------ | ---------------------------- | ------------------------------------ |
| **Return type**      | Covariant                | Can return subtype           | `(): Dog` → `(): Poodle` ✅          |
| **Parameter type**   | Contravariant            | Can accept supertype         | `(dog: Dog)` → `(animal: Animal)` ✅ |
| **Read-only arrays** | Covariant                | Can treat as supertype array | `Dog[]` → `Animal[]` ✅              |
| **Mutable arrays**   | Invariant (unsafe in TS) | Must be exact type           | `Dog[]` ←→ `Animal[]` ⚠️             |

## 🧠 The Memory Trick

**COvariant** = **CO**mes **OUT** (return values, producers)
**CONTRAvariant** = **CONTRA**dicts input / goes **IN** (parameters, consumers)

Remember: **"Out is CO, In is CONTRA"**

```typescript
// COvariant: Comes OUT
type Producer<T> = () => T; // T is covariant

// CONTRAvariant: Goes IN
type Consumer<T> = (value: T) => void; // T is contravariant
```

This is why function parameters are contravariant and return types are covariant!
