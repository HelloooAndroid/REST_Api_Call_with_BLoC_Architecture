# REST Api Call with BLoC Architecture

Repository contains example of REST api call with BLoC architecture.

## What is BLoC Architecture

BloC (Business Logic Component) is an architecture pattern introduced by Google at their IO conference this year. The idea behind it is to have separated components (BloC components) containing only the business logic that is meant to be easily shared between different Dart apps.

<b>The goal of this library is to make it easy to separate presentation from business logic, facilitating testability and reusability.</b>


## Module Functionality

1. Fetch response using Api
2. If response is successful, show result in list. 
3. Else show error with reload button

## Components
![](https://user-images.githubusercontent.com/53623174/88580424-348caf00-d069-11ea-9694-356a746f40e7.jpg)

### View
View contains UI of the module. It interact with controller for the state and data to manipulate UI on screen.

### BLoC
BLoc contains busines logic required to gather/manipulate data. 
It has `StreamController` which creates <b>stream</b> and <b>sink</b> to interact with state of the widgets.

### Repository
It is responsible for making REST call and pass data to BLoc.

### Data
It is source of the data i.e. Server/DB etc.


