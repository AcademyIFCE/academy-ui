# Contributing to the Project

## Fork this repository

First you must fork this project, and then clone your fork to your local machine with the following command:

`git clone git@github.com:<Your-Github-Username-Here>/academy-ui.git`

## Create your branch in your fork

After cloning your fork to your machine, you should 

1. Enter its local directory through the terminal

2. Create a new branch with your github username as its name and checkout to it. This can be done with the command:

`git checkout -b <Your-Github-Username-Here>`

## Adding your SwiftUI Component

To add your SwiftUI Component to the project, you need to:

1. Create a new folder with the name of the Component and place it inside the directory `Sources/AcademyUI`. 

2. Place your .swift files related to the component inside the folder you just created.

Remember: in order for the package to see it, at least your component's main View struct should be `public`. 

## Commit your changes

From the root directory of the project, commit your changes to your local branch and push it to your github fork with the commands: 
```
git add .
git commit -m "Adding <Name-of-your-SwiftUI-Component>"
git push -u origin <Your-Github-Username-Here>
```   

## Make a Pull Request

Now you should create a PR directly from your fork's branch to the original repository's main branch. 

1. Go to the [pull requests tab of the original repository](https://github.com/AcademyIFCE/academy-ui/pulls).

2. Click on the *New Pull Request* button.

3. Click on the *compare across forks* link.

4. Set the head repository to your fork, and the compare branch to the branch with your username.

That's it! Now you can finish creating your Pull Request and wait for someone to review it!


### Thank you for contributing! 🎉

