- What classes does each implementation include? Are the lists the same?

    The lists are the same.
    Implementation A and B includes CartEntry, ShoppingCart, Order.

- Write down a sentence to describe each class.

  Implementation A
    CartEntry : This class holds the 'unit_price' and 'quantity' variables.

    ShoppingCart : This class holds the 'entries' variable.

    Order : This class initializes a new ShoppingCart object and calculates the total price of its entries summing the sales tax to it.

    Implementation B
      CartEntry : This class holds the 'unit_price' and 'quantity' variables and calculates the price of each item depending on it.

      ShoppingCart : This class holds the 'entries' variable and calculates the total price of all of them combined.

      Order : This class initializes a new ShoppingCart object and calculates the total price of its entries summing the sales tax to it by using a helper method from the ShoppingCart class.

- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

    Implementation A
      The Order class has a ShoppingCart which has entries. I would think that this entries array is been populated with a bunch of CartEntry objects, but it is not explicit in the code above.

    Implementation B
      The Order class has a ShoppingCart instance which has a collection of entries, where each one of them has a price and a quantity.

- What data does each class store? How (if at all) does this differ between the two implementations?

    The two implementations store the same datas on each class. CartEntry: unit_price and quantity, ShoppingCart: entries, Order: cart.

- What methods does each class have? How (if at all) does this differ between the two implementations?

    Implementation A has only one method, 'total_price' and it is in the Order class.

    Implementation B has one method in each class. CartEntry has a 'price' method for its units, ShoppingCart has a 'price' method for its array with entries and Order has a total_price method for its cart.

- Consider the Order#total_price method. In each implementation:
  - Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

      It is logical to delegate the price calculations to its lower level classes since it has to do with their own variables, instead of keeping everything as a Order responsibility.

  - Does total_price directly manipulate the instance variables of other classes?

      It does directly manipulate the instance variables on other classes in the Implementation A. However, it does not do it on Implementation B, as it uses methods from other classes, instead of accessing its variables directly.

- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

    Implementation B is easier to modify since it would only be necessary to change how the CartEntry class is calculating the total price per amount of each unit.

- Which implementation better adheres to the single responsibility principle?

    Implementation B

- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?


-----------------------------------------------

Revisiting Hotel

- Deleted Room class since it really wasn't necessary and created a collection of integers from 1 to 19 that represent the rooms.

- Changed how the rooms available in the blocks were being accessed.
  Before I had the Manager simply 'occupying' a room when a new reservation was made and now the Block itself defines a collection of its available rooms and the manager makes a request to the Block to 'mark' the respective room off of its 'available rooms' collection, without touching it directly.
