# food-delivery-umain
 
This is an implementation for the assignment: https://github.com/apegroup/Code-test

## Explanation
- The project uses MVVM arquitecture with the Combine framework and Dependecy Injection.
- For DI, I used the [swift-dependencies](https://github.com/apegroup/Code-test) package.
- I added previews for both screens (`RestaurantList` and `RestaurantDetail`) using DI and mocked data.
- I extracted as many components as I could. I also added a Theme to handle some UI values that can be reused in all the app.
- I added some animation, nothing too fancy. 
- I added error handleling in the restaurants list screen.
- Added extra logic - if no filters are selected, the app will show all available restaurants.
