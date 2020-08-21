# Mod 1: # Mod 1 Dirty Bean Coffee Shop

  Not sure what to order at a coffee shop? People behind you starting to get impatient? Is your barista looking at you with dead eyes? Well now you have a handy app to help you decide what to order so you can avoid that awkward situation altogether!



## Technologies!

```
  - Platform: Ruby

  - ActiveRecord => version (6.0)
  - Sinatra => version (2.0.8.1)
  - Sinatra-ActiveRecord => version (2.0.18)
  - Sqlite3 => version (1.4.2)
  
  Gems:
  - gem "rake", "~> 13.0"
  - gem "sqlite3", "~> 1.4"
  - gem "require_all", "~> 3.0"
  - gem "tty-prompt"
  - gem "pastel-cli"
  - gem "tty-progressbar"
  - gem "tty-box"
  - gem "tty-spinner"
  - gem "tty-color"
  - gem "tty-cursor"
  - gem "catpix"
```

#### Setup

 To get this CLI app to work, follow these steps below:

 ```
 1.) $ bundle install 
    this gets all those lovely gems working~!
 2.) #Quick note!* If you do not have imagemackig installed, do the following:
   $ brew imagemagick
   if it doesn't work, follow up with this
   $ brew unlink imagemagick
   $ brew install imagemagick@6 && brew link imagemagick@6 --force
 3.) rake db:migrate! *then* rake db:seed
 4.) and voila! The app should work like a charm. 




### Features!

-Create a personal account with your name
- You can save an account under your name and access your previous ordered drinks
- Go through the steps of building your own custom drink of choice
- If you don't want to commit to a decision yourself let the app choose for you with our random drink feature!


### Status

 Complete!...mostly. 

## Inspiration

The inspiration for this app is the mutual love for coffee between my partner and I. 

## Contact Information

Shelley: https://github.com/sbrook13
Sydney:  https://github.com/sbrook13

