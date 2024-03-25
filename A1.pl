% include the data file
:-consult(data).

% my_length(L, N) is true if N is the number of elements in list L
my_length([], 0).
my_length([_|T], N) :-
    my_length(T, N1),
    N is N1 + 1.

% my_member(X, L) is true if X is a member of list L
my_member(X, [X|_]). 
my_member(X, [_|Tail]):-
    my_member(X, Tail).

% my_append(L1, L2, L3) is true if L3 is the result of appending L2 to L1
my_append([], L, L).
my_append([H|T], L, [H|R]):-
    my_append(T, L, R).


% List all orders of a specific customer (as a list).
list_orders(Customer, List) :-
    customer(CustomerID, Customer),
    list_orders(CustomerID, [], List).

list_orders(CustomerID, AccList, List) :-
    order(CustomerID, OrderID, Items), % if the customer has an order
    \+ my_member(order(CustomerID, OrderID, Items), AccList), % if the order is not already in the list
    my_append(AccList, [order(CustomerID, OrderID, Items)], NewAccList), % add the order to the list
    list_orders(CustomerID, NewAccList, List),  % continue searching for more orders
    !. % cut to stop searching for more orders
    
list_orders(_, List, List). % if the customer has no more orders, return the list

% Get the number of orders of a specific customer given customer Name.
countOrdersOfCustomer(Customer, Count) :-
    list_orders(Customer, List), % get the list of orders
    my_length(List, Count). % get the length of the list

% List all items in a specific customer order given customer Name and order id.
getItemsInOrderById(Customer, OrderID, Items) :-
    customer(CustomerID, Customer), % get the customer id
    order(CustomerID, OrderID, Items), % get the items in the order
    !. % cut to stop searching for more orders

% Get the num of items in a specific customer order given customer Name and order id.
getNumOfItems(Customer, OrderID, Count) :-
    getItemsInOrderById(Customer, OrderID, Items), % get the items in the order
    my_length(Items, Count). % get the length of the items list

% Calculate the price of a given order given Customer Name and order id
calcPriceOfOrder(Customer, OrderID, TotalPrice) :-
    getItemsInOrderById(Customer, OrderID, Items), % get the items in the order
    calcPriceOfItems(Items, 0, TotalPrice). % calculate the price of the items

calcPriceOfItems([], TotalPrice, TotalPrice). % if there are no more items, return the total price
calcPriceOfItems([Item|Tail], AccPrice, TotalPrice) :-
    item(Item, _, Price), % get the price of the item
    NewAccPrice is AccPrice + Price, % add the price to the accumulator
    calcPriceOfItems(Tail, NewAccPrice, TotalPrice). % continue calculating the price of the rest of the items


% return if this item or this company is boycotted or not
isBoycott(Companyname):-
    boycott_company(Companyname,_).
isBoycott(Item):-
    item(Item, Companyname, _), boycott_company(Companyname,_).

% prints justification of why we need to boycott this company
whyToBoycott(Companyname,Justification):-
    boycott_company(Companyname,Justification).

whyToBoycott(Item,Justification):-
    item(Item, Companyname, _),boycott_company(Companyname,Justification).

%Given an username and order ID, remove all the boycott items from this order.
removeBoycottItems([], []).
removeBoycottItems([H|T],ListOfNoBoycott):-
    isBoycott(H),
    removeBoycottItems(T,ListOfNoBoycott),
    !.
removeBoycottItems([H|T],[H|Result]):-
    removeBoycottItems(T,Result).

removeBoycottItemsFromAnOrder(Customer, OrderID,NewList):-
    getItemsInOrderById(Customer, OrderID, Items), % get the items in the order
    removeBoycottItems(Items, NewList).

%Given an username and order ID, update the order such that all boycott items are replaced by an alternative (if exists).
replaceBoycottItems([], []).
replaceBoycottItems([H|T],[Alternative|ListOfAlter] ):-
    isBoycott(H),alternative(H,Alternative),replaceBoycottItems(T,ListOfAlter),!;isBoycott(H),replaceBoycottItems(T,ListOfAlter).    

replaceBoycottItems([H|T], [H|ListOfAlter]):-
	replaceBoycottItems(T, ListOfAlter).
    
replaceBoycottItemsFromAnOrder(Customer, OrderID,NewList):-
    getItemsInOrderById(Customer, OrderID, Items), % get the items in the order
	replaceBoycottItems(Items,NewList).




% Given an username and order ID, calculate the price of the order after replacing all boycott items by its alternative
calcPriceAfterReplacingBoycottItemsFromAnOrder(Customer, OrderID, NewList, TotalPrice) :-
    replaceBoycottItemsFromAnOrder(Customer, OrderID, NewList), % replace the boycott items
    calcPriceOfItems(NewList, 0, TotalPrice). % calculate the price of the new list
