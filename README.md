# Device-Agnostic Design Course Project I - a9e342e8-ed65-40fe-8da0-93a149d0fe3a

## Deployment link: https://dsachelarie.github.io/quizas_quiz_web/

I apologize for not putting the right link in the submitted DEPLOYMENT.md. I forgot about this requirement and only realized that I incorrectly put the repo link in DEPLOYMENT.md after having already made the submission.

**Name of the application:** Quizas Quiz

**Brief description of the application:** An application for solving quizzes from different topics.

**3 key challenges faced during the project:** 
- When trying to pass a *BuildContext* object as a parameter to an async function, I was shown a warning stating that I shouldn't use *BuildContext* across async gaps, so I decided to remove it. However, I was not sure how to navigate to a different page without using *BuildContext*;
- While testing the home page, after using *tester.pumpWidget* to load the app, the list of topics wasn't shown, and I had no idea why;
- I found it challenging to structure the code into the proper files and folders from the beginning.

**3 key learning moments from working on the project:** 
- I found out that a callback function can be passed as a parameter in order to avoid using *BuildContext* across async gaps;
- I realized that, because of the API call, *tester.pumpWidget* wasn't enough for loading everything from the home page, so I called *tester.pump* afterwards;
- I learned that it is sometimes better to repeatedly restructure the project as it grows, rather than trying to stick to a fixed predecided outline.

**list of dependencies and their versions:**
- http: ^1.1.0
- go_router: ^10.1.2
- flutter_riverpod: ^2.4.0
- shared_preferences: ^2.2.1
- nock: ^1.2.3
- test: ^1.24.6
