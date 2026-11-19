# Dart OOP Assignment: Kigali Bus Card

**Name:** Missamou Mayembo Elbrice Gloirdy
**Student ID:** 25982

## My numbers
- D = 82, L = 2
- Starting balance = 1000 + (82 × 10) = 1820 RWF
- Bus fare = 200 + 82 = 282 RWF
- Student discount = 10 + 2 = 12%

## Output of main.dart
```
Error: name too short
Owner: Missamou Mayembo Elbrice Gloirdy  | Balance: 1820 RWF
Owner: Missamou Mayembo Elbrice Gloirdy | Balance: 1820 RWF
Error: top-up must be 500 to 50000 RWF
Topped up 2000 RWF
Paid 282 RWF
Paid 282 RWF
Owner: Missamou Mayembo Elbrice Gloirdy | Balance: 3256 RWF
Student discount: 33 RWF
Paid 249 RWF
Owner: Missamou Mayembo Elbrice Gloirdy | Balance: 1571 RWF
Student card: 12% off
```

## Part 1: Why no setter for balance?
A setter would let any code set the balance to any value (for example 1000000), skipping the rules. Without it, the balance can only change through `topUp` (checked amounts) and `pay` (declined if not enough money), so the card stays safe and consistent.

## Part 2: What does ~/ do?
`/` gives a decimal (double) result, `~/` gives integer division: it divides and drops the decimal part.
- `print(237 * 17 / 100);` prints `40.29`
- `print(237 * 17 ~/ 100);` prints `40`

With my numbers: `282 * 12 / 100` = 33.84, while `282 * 12 ~/ 100` = 33. The discount must be an `int`, so `~/` is used.

## Part 4: Bug table
| Bug | The line | Why it is wrong (my words) | My fix |
|---|---|---|---|
| 1 | `String _brand;` / `int _battery;` | Non-nullable fields have no starting value, so Dart gives an error. | `String _brand = '';` and `int _battery = 0;` |
| 2 | `SmartPhone(String brand, int battery, String system) {` | The constructor does not call the parent constructor; Phone needs brand and battery. | Add `: super(brand, battery)` |
| 3 | `@override void restart()` | `@override` only works if the parent has that method; Phone has no `restart`. | Remove `@override` |
| 4 | `p.battery = 100;` | There is no setter for battery, so it cannot be assigned. | Add `set battery(int value)` accepting only 0 to 100 |
| 5 | `print(p.battery());` | `battery` is a getter, not a method, so it must not be called with `()`. | `print(p.battery);` |
| Not a bug | `Phone p = new Phone('Tecno', 50);` | `new` is optional in Dart but still allowed, so the line is valid. | (none) |

Fixed program prints: `100`

## Part 5
My prediction: `1` then `5`.
- `a`: `add()` makes items 1, then `a.items = -5` is refused by the setter (value < 0), so it prints 1.
- `b`: BigBag's `add()` calls `super.add()` twice, so each `add()` adds 2. After two calls items = 4, then `b.items = 4 + 1` = 5, so it prints 5.