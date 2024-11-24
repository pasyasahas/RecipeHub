# RecipeHub

### Steps to Run the App
-> Import the project to xcode
-> Build the app to the simulator

- Scroll to view all the recipes
- Tap on the show more to view the website and YouTube link.
- Tap on website to view the source website of the recipe.
- Tap on YouTube to view a YouTube video of the recipe.
- Tap on show less to hide details.
- Swipe down at the top of the list to refresh


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
-> Image caching:
       Made sure that images were properly cached using file manager to reduce network call. This directly improves the performance of the app as fetching images from local memory is faster than downloading images. This allows loading images without any placeholders.
       
-> UI:
      Designed custom cards to display each recipe. A UI is one of the most import aspects of the app as that is what attracts the user and hooks the user to the app, a user-friendly ui with good animations will have a huge impact on the user.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
-> Spent about 6 hours on the project, the specific split for each part of of the project is as below:

    UI: 1.5 hours
    ViewModels: 1 hour
    Data service: 1 hour
    File Manager: 1 hour
    Testing: 1.5 hours

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I made a tradeof on scaling by using URLSession over Alamofire. At the moment it were only simple get requests but if the same project was to be scaled up to creating recipies which would add post requests as well, we would then have to add Alamofire and refactor the existing network requests. 

### Weakest Part of the Project: What do you think is the weakest part of your project?
Unit testing is the weakest part of the project. Unit test could have negative test cases as well as validation of each custom error included.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
I refrained from using any third party dependencies as the application in itself is quite small also since the network calls are simple get requests I used URLSession rather than importing Alamofire.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- The app supports:
  - iPhone, iPad
  - Portrait, Landscape
  - Light mode, Dark mode
- I have designed custom errors for all test cases so if we intigrate firebase to the project and monitor logs if would make it easy to navigate to where the error popped from.
