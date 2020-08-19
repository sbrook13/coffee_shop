Drink.destroy_all

americano = Drink.create({
    name: "Americano",
    description: "A strong espresso drink made with water instead of milk. A great option for that espresso taste but make it last.", 
    caffeine: true, 
    milk: nil, 
    sweet: false, 
    temp: nil})
flavored_americano = Drink.create({
    name: "Flavored Americano",
    description: "A strong espresso drink made with water instead of milk with an added flavor of your choice. Great for a sweet drink if you're not fond of milk.",
    caffeine: true,
    milk: 0,
    sweet: true,
    temp: nil})
iced_coffee = Drink.create ({
    name: "Iced Coffee", 
    description: "A summer favorite! Strong in flavor and caffeine, this drink is super customizable! You can add milk and syrups to really make this drink exactly the what you want!", 
    caffeine: true, 
    milk: nil, 
    sweet: nil,
    temp: "iced"})
latte = Drink.create({
    name: "Latte", 
    description: "An espresso drink with steamed milk. Traditionally served as an 8oz drink, it could also be ordered in larger sizes. Smooth, creamy, and tasty!", 
    caffeine: true, 
    milk: 3, 
    sweet: false,
    temp: nil})
flavored_latte = Drink.create({
    name: "Flavored Latte",
    description: "An espresso drink with steamed milk flavored with a syrup of your choice. Great if you want an added sweetness to your coffee.", 
    caffeine: true,
    milk: 3, 
    sweet: true,
    temp: nil})
frappe = Drink.create({
    name: "Frappe",
    description: "A blended drink with espresso, milk, and syrup. Amazing for hot summer days and very customizable! Don't drink too fast or you'll get a brainfreeze!", 
    caffeine: true, 
    milk: 3, 
    sweet: true,
    temp: "blended"})
cortado = Drink.create({
    name: "Cortado", 
    description: "An espresso drink that's a 1:2 ratio of espresso and steamed milk. Often the choice for those who want that strong kick of espresso, but still want that subtle creaminess of the milk", 
    caffeine: true, 
    milk: 1, 
    sweet: false,
    temp: "hot"})
cappuccino = Drink.create({
    name: "Cappuccino", 
    description: "An espresso drink that's 1/3 espresso, 1/3 steamed milk, and 1/3 milk foam. A delicious traditional Italian beverage. It's light and frothy, with more of an espresso taste present than with a latte.", 
    caffeine: true, 
    milk: 2, 
    sweet: false,
    temp: "hot"})
macchiato = Drink.create({
    name: "Macchiato", 
    description: "An espresso drink with a tiny dollop of frothy milk. Did you know that the word macchiato means marked in Italian? This drink was named this because it's marked with that classic white dot of milk foam in the center!", 
    caffeine: true, 
    milk: 1, 
    sweet: false,
    temp: "hot"})
undertow = Drink.create({
    name: "Undertow", 
    description: "A layered drink starting with syrup, usually vanilla, cold half and half, and topped with espresso to make a beautiful and delicious shot. Great for a quick and tasty burst of energy. Starbucks did not invent this.", 
    caffeine: true, 
    milk: 1, 
    sweet: true,
    temp: "hot"})


