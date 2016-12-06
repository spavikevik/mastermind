# Mastermind with AI
From [Wikipedia.org](http://en.wikipedia.org)
> Mastermind or Master Mind is a code-breaking game for two players. The modern game with pegs was invented in 1970 by Mordecai Meirowitz, an Israeli postmaster and telecommunications expert.

### Game rules
One player (either computer or human) creates a 4 digit code and it is the task of the other player (a human or a computer) to break it. Each digit can be in range from 1-6 (which can represent 6 colors).
There are 12 turns available to the player. After each guess, the program outputs the number of digits which are both correct and at the correct position, and digits which are correct color but wrong position.

Although there isn't a gameplay wrapper, the game can be played as follows
in **IRB** load *game.rb* and create a new instance of the class **Game**. Without any arguments, the new object assumes that the game is to be played by a human and the computer will generate a secret code. To play, simply invoke the **#play** method on the object. 

If you want the computer to break a code that you have come up with, when instantiating the **Game** class, pass the *:com* option for the constructor, after which you will be asked to enter a secret code.
