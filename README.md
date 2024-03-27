### Repository: Customer Orders Management System

This repository contains a Prolog program for managing customer orders, items, boycott companies, and their alternatives.

### Contributors:
- [Abdelrhman Mostafa](https://github.com/3bde1r7man)
- [Sama Ahmed](https://github.com/SamaAhmedS)

###  Predicates:
1. **List Orders of a Specific Customer**
   - Predicate: `list_orders(CustomerUsername, OrdersList)`
   - Lists all orders of a specific customer.

2. **Count Orders of a Specific Customer**
   - Predicate: `countOrdersOfCustomer(CustomerUsername, Count)`
   - Gets the number of orders of a specific customer.

3. **Get Items in a Specific Customer Order**
   - Predicate: `getItemsInOrderById(CustomerUsername, OrderID, Items)`
   - Lists all items in a specific customer order.

4. **Get Number of Items in a Specific Customer Order**
   - Predicate: `getNumOfItems(CustomerUsername, OrderID, Count)`
   - Gets the number of items in a specific customer order.

5. **Calculate Price of a Given Order**
   - Predicate: `calcPriceOfOrder(CustomerUsername, OrderID, TotalPrice)`
   - Calculates the price of a given order.

6. **Determine Whether to Boycott an Item or Company**
   - Predicate: `isBoycott(ItemOrCompanyName)`
   - Determines whether to boycott an item or company.

7. **Get Justification for Boycotting a Company or Item**
   - Predicate: `whyToBoycott(ItemOrCompanyName, Justification)`
   - Provides justification for boycotting a company or item.

8. **Remove Boycott Items from an Order**
   - Predicate: `removeBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList)`
   - Removes all the boycott items from a specific order.

9. **Replace Boycott Items from an Order with Alternatives**
   - Predicate: `replaceBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList)`
   - Updates the order such that all boycott items are replaced by an alternative (if exists).

10. **Calculate Price of Order After Replacing Boycott Items**
    - Predicate: `calcPriceAfterReplacingBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList, TotalPrice)`
    - Calculates the price of the order after replacing all boycott items with their alternatives (if they exist).

11. **Calculate Difference in Price Between Item and Its Alternative**
    - Predicate: `getTheDifferenceInPriceBetweenItemAndAlternative(ItemName, AlternativeItem, PriceDifference)`
    - Calculates the difference in price between a boycott item and its alternative.

12. **Insert/Remove Item, Alternative, or New Boycott Company**
    - Predicates: `add_item(ItemName, CompanyName, Price)`, `remove_item(ItemName, CompanyName, Price)`, `add_alternative(ItemName, AlternativeItem)`, `remove_alternative(ItemName, AlternativeItem)`, `add_boycott_company(CompanyName, Justification)`, `remove_boycott_company(CompanyName)`
    - Inserts or removes an item, alternative, or boycott company from the knowledge base.
