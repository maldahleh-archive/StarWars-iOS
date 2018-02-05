# StarWars
StarWars is an iOS app that displays information on characters, vehicles and starships from the SWAPI.

## Project Instructions
A short time ago, in a Galaxy not so far away, you were taught about APIs. Now is your chance to harness the force (of newfound knowledge) and put the Star Wars API (SWAPI) to use in an iOS app.

Using what you learned about APIs, Networking, Concurrency, and JSON you will get information about three types of Star Wars entities: people, vehicles and starships. Each entity type should have its own view from an UI perspective. However, they can be based on common code and/or storyboards. See below for links to the mockups for the app. Please note that even though the API is paginated, for the basic requirement of the project you only need to retrieve and display the first page of results for a given API request.

In the mockup, you will notice that regardless of which view a user is on, there is a bar across the top showing the largest and smallest member of the group. In addition, because all measurements are given in metric units (meters), you will need to create a feature that convert the units to British units (inches), at a tap of a button. For starships and vehicles, students will need to create a button that can convert “Galactic Credits” to US Dollars, based on a exchange rate provided by the user in a text field.

Lastly, please include appropriate error handling. The app needs to demonstrate the ability to anticipate and handle errors for at least the following possible issues:

* The device went offline during an API call
* A user entering a 0 or negative exchange rate
* An error resulting from a key or element missing from the JSON returned from the API

If you would like to get an “exceeds expectations” grade, you will also need to

* Implement an additional text view on the “people” screen that displays a list of vehicles or starships that are associated with that person
* As mentioned earlier, make sure the API requests retrieve all pages of results, and any value of the entire result set can be selected by the user
