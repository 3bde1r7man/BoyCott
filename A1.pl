% Rules

% List all orders of a specific customer (as a list).
list_orders(Customer, List) :-
    customer(CustomerID, Customer),
    list_orders(CustomerID, [], List).

list_orders(CustomerID, AccList, List) :-
    order(CustomerID, OrderID, Items), % if the customer has an order
    \+ member(order(CustomerID, OrderID, Items), AccList), % if the order is not already in the list
    append(AccList, [order(CustomerID, OrderID, Items)], NewAccList), % add the order to the list
    list_orders(CustomerID, NewAccList, List),  % continue searching for more orders
    !. % cut to stop searching for more orders
    
list_orders(_, List, List). % if the customer has no more orders, return the list













