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

% member(X, L) is true if X is a member of list L
member(X, [X|_]). 
member(X, [_|Tail]):-
    member(X, Tail).

% append(L1, L2, L3) is true if L3 is the result of appending L2 to L1
append([], L, L).
append([H|T], L, [H|R]):-
    append(T, L, R).


% return if this item or this company is boycotted or not
isBoycott(Companyname):-
    boycott_company(Companyname,_).

% prints justification of why we need to boycott this company
whyToBoycott(Companyname,Justification):-
    boycott_company(Companyname,Justification).









