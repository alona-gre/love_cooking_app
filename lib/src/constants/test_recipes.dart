import 'package:love_cooking_app/src/features/recipes/domain/ingredient.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';

/// Test recipes to be used until a data source is implemented
const kTestRecipes = [
  Recipe(
    id: 'r1',
    categories: ['dinner', 'quick & easy', 'italian'],
    title: 'Spaghetti with Tomato Sauce',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    ingredients: [
      Ingredient(quantity: 4, unit: 'pc', name: 'Tomatoes'),
      Ingredient(quantity: 4, unit: 'pc', name: 'of Olive Oil'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Onion'),
      Ingredient(quantity: 250, unit: 'g', name: 'Spaghetti'),
      Ingredient(name: 'Spices'),
      Ingredient(name: 'Cheese (optional)'),
    ],
    portion: 2,
    steps: [
      'Cut the tomatoes and the onion into small pieces.',
      'Boil some water - add salt to it once it boils.',
      'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
      'In the Recipetime, heaten up some olive oil and add the cut onion.',
      'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
      'The sauce will be done once the spaghetti are.',
      'Feel free to add some cheese on top of the finished dish.'
    ],
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    description:
        'A comforting classic, this dish features tender spaghetti tossed in a rich and flavorful tomato sauce.',
  ),
  Recipe(
    id: 'r2',
    categories: ['exotic', 'sandwiches', 'lunch'],
    title: 'Toast Hawaii',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    portion: 1,
    ingredients: [
      Ingredient(quantity: 1, unit: 'slice', name: 'White Bread'),
      Ingredient(quantity: 4, unit: 'pc', name: 'Tomatoes'),
      Ingredient(quantity: 1, unit: 'slice', name: 'Ham'),
      Ingredient(quantity: 2, unit: 'slices', name: 'Cheese'),
      Ingredient(name: 'Butter'),
    ],
    steps: [
      'Butter one side of the white bread',
      'Layer ham, the pineapple and cheese on the white bread',
      'Bake the toast for round about 10 minutes in the oven at 200°C'
    ],
    description:
        'A fun and unexpected twist on toast, featuring ham, pineapple, and cheese melted together for a sweet and savory combination.',
  ),
  Recipe(
    id: 'r3',
    categories: [
      'hamburgers',
      'dinner',
      'lunch',
    ],
    portion: 2,
    title: 'Classic Hamburger',
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    ingredients: [
      Ingredient(quantity: 300, unit: 'g', name: 'Cattle Hack'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Tomatoes'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Cucumber'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Onion'),
      Ingredient(name: 'Ketchup'),
      Ingredient(quantity: 2, unit: 'pc', name: 'Burger Buns'),
    ],
    steps: [
      'Form 2 patties',
      'Fry the patties for c. 4 minutes on each side',
      'Quickly fry the buns for c. 1 minute on each side',
      'Bruch buns with ketchup',
      'Serve burger with tomato, cucumber and onion'
    ],
    isLactoseFree: true,
    description:
        'A satisfying all-American staple, this juicy burger is layered with your favorite toppings on a toasted bun.',
  ),
  Recipe(
    id: 'r4',
    categories: [
      'german',
      'dinner',
      'lunch',
    ],
    title: 'Wiener Schnitzel',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    ingredients: [
      Ingredient(quantity: 8, unit: 'pc', name: 'Veal Cutlets'),
      Ingredient(quantity: 4, unit: 'pc', name: 'Eggs'),
      Ingredient(quantity: 200, unit: 'g', name: 'Bread Crumbs'),
      Ingredient(quantity: 100, unit: 'g', name: 'Flour'),
      Ingredient(quantity: 300, unit: 'ml', name: 'Butter'),
      Ingredient(quantity: 100, unit: 'g', name: 'Vegetable Oil'),
      Ingredient(name: 'Salt'),
      Ingredient(name: 'Lemon Slices'),
    ],
    portion: 2,
    steps: [
      'Tenderize the veal to about 2–4mm, and salt on both sides.',
      'On a flat plate, stir the eggs briefly with a fork.',
      'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
      'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
      'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
      'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
      'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
    ],
    description:
        'A crispy and flavorful Austrian dish, this veal cutlet is breaded and fried to golden perfection.',
  ),
  Recipe(
    id: 'r5',
    categories: [
      'light'
          'lunch',
      'dinner',
    ],
    title: 'Salad with Smoked Salmon',
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    ingredients: [
      Ingredient(name: 'Arugula'),
      Ingredient(name: 'Lamb\'s Lettuce'),
      Ingredient(name: 'Parsley'),
      Ingredient(name: 'Fennel'),
      Ingredient(quantity: 200, unit: 'g', name: 'Smoked Salmon'),
      Ingredient(name: 'Mustard'),
      Ingredient(name: 'Balsamic Vinegar'),
      Ingredient(name: 'Olive Oil'),
      Ingredient(name: 'Salt and Pepper'),
    ],
    portion: 2,
    steps: [
      'Wash and cut salad and herbs',
      'Dice the salmon',
      'Process mustard, vinegar and olive oil into a dessing',
      'Prepare the salad',
      'Add salmon cubes and dressing'
    ],
    isGlutenFree: true,
    isVegetarian: true,
    isLactoseFree: true,
    description:
        'A light and refreshing option, this salad features smoked salmon for a delicious smoky flavor.',
  ),
  Recipe(
    id: 'r6',
    categories: [
      'dessert',
      'light',
    ],
    title: 'Delicious Orange Mousse',
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    ingredients: [
      Ingredient(quantity: 4, unit: 'pc', name: 'Sheets of Gelatine'),
      Ingredient(quantity: 150, unit: 'ml', name: 'Orange Juice'),
      Ingredient(quantity: 80, unit: 'g', name: 'Sugar'),
      Ingredient(quantity: 300, unit: 'g', name: 'Yoghurt'),
      Ingredient(quantity: 200, unit: 'g', name: 'Cream'),
      Ingredient(name: 'Orange Peel'),
    ],
    portion: 2,
    steps: [
      'Dissolve gelatine in pot',
      'Add orange juice and sugar',
      'Take pot off the stove',
      'Add 2 tablespoons of yoghurt',
      'Stir gelatin under remaining yoghurt',
      'Cool everything down in the refrigerator',
      'Whip the cream and lift it under die orange mass',
      'Cool down again for at least 4 hours',
      'Serve with orange peel',
    ],
    isVegetarian: true,
    description:
        'A decadent and delightful dessert, this orange mousse is light and airy with a refreshing citrusy taste.',
  ),
  Recipe(
    id: 'r7',
    categories: [
      'breakfast'
          'quick & easy',
      'lunch'
    ],
    title: 'Pancakes',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    ingredients: [
      Ingredient(quantity: 1.5, unit: 'cups', name: 'all-purpose Flour'),
      Ingredient(quantity: 3.5, unit: 'tsp', name: 'Baking Powder'),
      Ingredient(quantity: 1, unit: 'tsp', name: 'Salt'),
      Ingredient(quantity: 1, unit: 'tbsp', name: 'White Sugar'),
      Ingredient(quantity: 1.25, unit: 'cups', name: 'Milk'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Egg'),
      Ingredient(quantity: 3, unit: 'tbsp', name: 'Butter, melted'),
    ],
    portion: 2,
    steps: [
      'In a large bowl, sift together the flour, baking powder, salt and sugar.',
      'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
      'Heat a lightly oiled griddle or frying pan over medium high heat.',
      'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
    ],
    isGlutenFree: true,
    isVegetarian: true,
    description:
        'Fluffy and delicious, these pancakes are perfect for a satisfying breakfast or brunch.',
  ),
  Recipe(
    id: 'r8',
    categories: [
      'asian',
      'dinner',
      'lunch',
    ],
    title: 'Creamy Indian Chicken Curry',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    ingredients: [
      Ingredient(quantity: 4, unit: 'pc', name: 'Chicken Breasts'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Onion'),
      Ingredient(quantity: 2, unit: 'cloves', name: 'Garlic'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Piece of Ginger'),
      Ingredient(quantity: 4, unit: 'tbsp', name: 'Almonds'),
      Ingredient(quantity: 1, unit: 'tsp', name: 'Cayenne Pepper'),
      Ingredient(quantity: 500, unit: 'ml', name: 'Coconut Milk'),
    ],
    portion: 2,
    steps: [
      'Slice and fry the chicken breast',
      'Process onion, garlic and ginger into paste and sauté everything',
      'Add spices and stir fry',
      'Add chicken breast + 250ml of water and cook everything for 10 minutes',
      'Add coconut milk',
      'Serve with rice'
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    description:
        'A flavorful and aromatic dish, this chicken curry is simmered in a creamy sauce packed with Indian spices.',
  ),
  Recipe(
    id: 'r9',
    categories: ['dessert', 'exotic'],
    title: 'Chocolate Souffle',
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 45,
    ingredients: [
      Ingredient(quantity: 1, unit: 'tsp', name: 'melted Butter'),
      Ingredient(quantity: 2, unit: 'tbsp', name: 'white Sugar'),
      Ingredient(
          quantity: 2,
          unit: 'oz',
          name: '70% dark Chocolate, broken into pieces'),
      Ingredient(quantity: 1, unit: 'tbsp', name: 'Butter'),
      Ingredient(quantity: 1, unit: 'tbsp', name: 'all-purpose Flour'),
      Ingredient(quantity: 4.33, unit: 'tbsp', name: 'cold Milk'),
      Ingredient(quantity: 1, unit: 'pinch', name: 'Salt'),
      Ingredient(quantity: 1, unit: 'pinch', name: 'Cayenne Pepper'),
      Ingredient(quantity: 1, unit: 'pc', name: 'Large Egg Yolk'),
      Ingredient(quantity: 2, unit: 'pc', name: 'Large Egg Whites'),
      Ingredient(quantity: 1, unit: 'pinch', name: 'Cream of Tartar'),
      Ingredient(quantity: 1, unit: 'tbsp', name: 'white Sugar'),
    ],
    portion: 2,
    steps: [
      'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
      'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
      'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
      'Place chocolate pieces in a metal mixing bowl.',
      'Place bowl over a pan of about 3 cups hot water over low heat.',
      'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
      'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
      'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
      'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
      'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
      'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
      'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
      'Transfer a little less than half of egg whites to chocolate.',
      'Mix until egg whites are thoroughly incorporated into the chocolate.',
      'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
      'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
      'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
    ],
    isGlutenFree: true,
    isVegetarian: true,
    description:
        'A luxurious and impressive dessert, this chocolate souffle is light and airy with a rich chocolate flavor.',
  ),
  Recipe(
    id: 'r10',
    categories: [
      'light',
      'lunch',
      'dinner',
    ],
    title: 'Asparagus Salad with Cherry Tomatoes',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    ingredients: [
      Ingredient(name: 'White and Green Asparagus'),
      Ingredient(quantity: 30, unit: 'g', name: 'Pine Nuts'),
      Ingredient(quantity: 300, unit: 'g', name: 'Cherry Tomatoes'),
      Ingredient(name: 'Salad'),
      Ingredient(name: 'Salt, Pepper and Olive Oil'),
    ],
    portion: 2,
    steps: [
      'Wash, peel and cut the asparagus',
      'Cook in salted water',
      'Salt and pepper the asparagus',
      'Roast the pine nuts',
      'Halve the tomatoes',
      'Mix with asparagus, salad and dressing',
      'Serve with Baguette'
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    description:
        'A healthy and vibrant salad, this option features fresh asparagus spears and sweet cherry tomatoes for a delightful summer dish.',
  ),
];
