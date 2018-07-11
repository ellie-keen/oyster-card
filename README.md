### Oystercard

#### Description

This is a command line application to be used with the REPL `irb` written with the OOP language, Ruby. 

Here, I have used test-driven development to drive this project using Rspec and paired on this challenge. 

This program aims to emulate the oystercards used as part of TFLs system.

------

#### Goals

- I have written code that is easy to change

- I have written code that is readable

- Test-Driven (Feature and Unit testing)

- Stubbing unit tests

- Building with objects

- A solid undertsanding of how ruby works

- Working with User Stories

  

------

#### Installation

```
git clone https://github.com/ellie-keen/boris-bikes.git
cd boris-bikes
```

------

#### How to use

Open your REPL:

```
irb
require './lib/oystercard.rb'
```

Create Oystercard object:

```
card = Oystercard.new
```

You are now able to top up your card, touch in and touch out depending on fare and balance.

```
card.top_up(50)
card.touch_in("London Bridge")
card.touch_out("Camden")
```

---

#### User Stories

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```





