# Know Shop
This is a sample application designed to streamline the process of shopping for the campus junta. It has interfaces for both the customer and the shopkeeper. The customer can check if a particular shop is open or not, view it's menu, contact details and top shops of the week category wise. Also there is an option to favourite an item, add to cart and place the order.The shopkeeper can update his shop's status whether open or closed, edit his menu and his earnings over the past week.

# User Research
* The target audience for our project includes all the iitg students, professors and scholar i.e, anyone with iitg email(as of now).
* Upon consultataion with students we came to the conclusion that the major problems faced by them are knowing whether a shop is open or not at a given time, delay in preparing food items, wastage of time in printing large documents, unavailibilty of shop details etc.
* On the shopkeeper's side we interviewed a number of shopkeepers within and outside the campus and came to the following conclusion :   
  * Groceries and general stores have a very large list of items hence it is practically impossible for them to maintain their item list.
  * Same is the problem for stationaries and juice centers where due to large variety of items, shopkeepers are reluctant to maintain their item lists.
  * Food shops don't have this problem hence we have implemented menu, cart, favourite and order status pages for them.
  * Any shop starts preparing their order only after the payment has been done by the user side.
  * For stationaries we have implemented file upload interface which reduces the time for printing the pages.
  * Shopkeepers get to know their earning history as well as their rating 
  * There exists no unique identification for shopkeepers within the campus, hence we decided to do a physical verification after the sign up process.
* Not all shops agree to delivery services.
# Planned Updates

We had planned the following features for future Updates:  
  * Add offer page for the Shopkeepers where they can add bogo offer, discounts and combo deals. He can choose any one of these offers and customize them according to his requirments.
  * We will update the open/close status of the shop according to the shop timings given by the shopkeeper.The shopkeeper can further update the status using toggle button.
  * Integrating delivery services for shops which offer them.
  * Notification system.

# Tech Stack
* Flutter
* Firebase
* Firestore
* Figma




# Features
## Customer side:   
* Login/Sign-up using iitg email id.  
* Shops can be searched using search bar as well as category tabs.  
* User can edit his/her profile and change password.  
* Food shops are divided in accordance to their location namely Khokha, Market Complex, Food Court and Canteen. 
* Users can view the list of food shops as well as the top 5 shops in each of these locations. Moreover he can see which shop is currently open. 
* Menu page for each shop where one can view items currently available, favourite a product, add a product to the cart.He can also view the shop details and contact the shopkeeper.  
* Favourite page where one can view his favourite items, remove an item from favourites or add a favourite item to his cart.  
* Individual carts for each shop where one can set the quantity, remove an item, add more items from the same shop, view the total amount and request for order.  
* Upon requesting an order user will be redirected to order status page. Once the request is accepted by the shopkeeper he can make payment for his order.
* In the orders page one can view his past orders as well as his active orders. He has the option to review or reorder his past order. He can also see the order status of his active order.  
* After the payment a qr code will be generated which has to be scanned by the shopkeeper to verify one's order.  
* One can send items to be printed in stationary shops beforehand and collect it later saving time. The order status screen is same as that for food shops.  
* One can view the list of juice centers, check wether they are open or not,view the shop details and contact the shopkeeper.  
* Miscellaneous shops include groceries, barber shops, gift shops etc. One can view the list of shops, check wether they are open or not,view the shop details and contact the shopkeeper.  

## Shopkeeper side:  
* Login if he/she already has an account. Sign-up, select the category of shop and apply for physical verification.
* Set wether the shop is open or not.  
* For food shops one can view today's total earning, dynamic graph displaying the earnings over the past week, change profile info and view rating.  
* Orders page displaying active orders and pending orders. 
* Active orders shows orders whose payment has been done. Here the shopkeeper can set if the order is ready. Also he can scan the qr for the verification of the correct customer.
* Pending orders shows orders which has been requested by the customer the shopkeeper has option to accept or reject order request.
* Menu page displaying the menu of the shop where one can edit item name price and set availability.
* For stationary shop one can edit his profile, accept/reject pending orders, ready the active orders and scan the qr for final verification.
* For juice centers and miscellaneous shops one can edit the profile and set whether the shop is open or not.

# User Interface
[Click here to open figma file](https://www.figma.com/file/yleq06SJFDa2P7JOJuud2H/KRITI-SOFTWARE?node-id=0%3A1&t=c8loi0acXoobQauX-1)



# Contributers
  * [Priyanshu Mahawar](https://github.com/Perseus29)
  * [Sparsh Mittal](https://github.com/Sparsh752)
  * [Abhinav Kumar](https://github.com/Abhinav1-Kumar)
  * [Shivam Agarwal](https://github.com/shivaga)
  * [Yash Kataria](https://github.com/yashhkataria)
  * [Piyush Gautam](https://github.com/py-2312)
  * [Tarun Kumar](https://github.com/tarunnn3301)
  * [Sarvesh Gholap](https://github.com/sarg19)