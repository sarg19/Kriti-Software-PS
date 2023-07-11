# KnowShop
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
<div style="display: inline-block;">
  <img src="https://user-images.githubusercontent.com/95137162/252489225-02584495-3a85-4afb-a89b-005d10b2fe69.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490153-64ac8ba8-dc74-4958-88c8-9e5c63b3676d.jpeg" width="200" height="400"/>
</div>

## Customer Side:
<div style="display: inline-block;">
  <img src="https://user-images.githubusercontent.com/95137162/252490281-d7888038-3afc-47f9-8184-dddc567c2543.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490333-234439cc-883e-4720-bc2a-c52c2a887772.jpeg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490403-04906df4-634a-4dcd-a468-a054a0c67748.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490431-9e98a51a-8478-439f-a7c9-5ee6bab08292.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490453-0fd442e5-289b-4dbc-bbeb-9bb4efc2ca7a.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490465-d285c90b-a3ab-49e3-bf75-12680fdaed05.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490474-0b044a70-c6a7-4628-9c98-115e565610f1.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490583-6a410e2f-0d28-4cca-aa83-22bce450676c.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490609-f8b742d8-617d-4382-a8d3-b4cfce24dd9f.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490627-29570936-3dd2-470f-b769-eb3d1910b8f9.jpg" width="200" height="400"/>

  <img src="https://user-images.githubusercontent.com/95137162/252490644-fed3ff1a-be45-4673-ac81-9bda00400ee9.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490668-2ca29b17-b93f-45ed-9998-5a450de926a9.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490705-62c4e770-a09d-45ce-bcff-c7f08ecd241e.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490738-999f6781-4f1d-4772-a67a-42734516ef42.jpg" width="200" height="400"/>

  <img src="https://user-images.githubusercontent.com/95137162/252490777-e45f78f2-d265-4a26-a41a-d717deb74298.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490818-11cd81c2-87b6-4a71-8f7b-99b0ad876c62.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490824-36940e43-78f8-4183-a067-9b5511eeea39.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490833-05845b62-ff19-4434-8766-84168f8cd2f3.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252490857-f4413bd4-7ab2-426b-aaab-5a24f1a3a850.jpg" width="200" height="400"/>
</div>

## Shopkeeper side:

<div style="display: inline-block;">
 <img src="https://user-images.githubusercontent.com/95137162/252804120-b6e42830-f2e2-441d-b3a2-2d462e4e422f.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804139-b52be5f3-f93b-4249-9614-5840c4f5ab80.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804586-2f99e50a-e47d-4f61-a97e-758f654e5775.jpeg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804601-63fdb8ea-308f-4d95-a5e2-f32a6358f9eb.jpeg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804161-be2a135f-78d8-402b-9bc6-88620f4dcb66.jpg" width="200" height="400"/>

 <img src="https://user-images.githubusercontent.com/95137162/252804175-44c6e5c0-2695-464b-bbbf-fedfd124a480.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804187-f3aa5eb9-f5f5-4de1-91d2-7038f15c69c8.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804244-8e42f747-7322-4e07-a61c-af34f5b27c65.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804275-6bd41870-5581-45ab-be22-1824b0ec09f4.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804287-9981deda-5fc0-4d3b-9f5e-364f232a1a03.jpg" width="200" height="400"/>

   <img src="https://user-images.githubusercontent.com/95137162/252804308-9f516a8d-43be-4fcf-b1f3-ff777e7762bc.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804340-cbd2991e-2737-4a0c-9b21-ab5ee3e7d0ec.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804352-14ea4931-9654-4567-b3c8-44c950f4f236.jpg" width="200" height="400"/>
  <img src="https://user-images.githubusercontent.com/95137162/252804363-ffae812e-abef-4334-9664-390b6b2caa1b.jpg" width="200" height="400"/>
</div>
# UI Figma File
[Click here to open figma file](https://www.figma.com/file/yleq06SJFDa2P7JOJuud2H/KRITI-SOFTWARE?node-id=0%3A1&t=c8loi0acXoobQauX-1)

# Apk Drive Link
[Click here to download apk](https://drive.google.com/file/d/1kd5lJE9X4TWQdbKabiR8sq6pmB6JF_6W/view?usp=share_link)

## Installation
Download the apk from the link above in your android device and click install. The app will be installed in the mobile.

# Video demonstration of the app
[Click here for video link](https://drive.google.com/file/d/1xtJWnrAg8HkdciFDgmpQDREzvQJvjIU3/view?usp=share_link)




# Contributers
  * [Priyanshu Mahawar](https://github.com/Perseus29)
  * [Sparsh Mittal](https://github.com/Sparsh752)
  * [Abhinav Kumar](https://github.com/Abhinav1-Kumar)
  * [Shivam Agarwal](https://github.com/shivaga)
  * [Yash Kataria](https://github.com/yashhkataria)
  * [Piyush Gautam](https://github.com/py-2312)
  * [Sarvesh Gholap](https://github.com/sarg19)
  * [Tarun Kumar](https://github.com/tarunnn3301)
