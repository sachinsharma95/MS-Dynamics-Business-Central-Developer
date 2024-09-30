## Sales Order Data Flow in Businee central
----

In Microsoft Dynamics 365 Business Central, the **sales order data flow** involves the following core tables. Here is the breakdown:

### 1. **Master Data Tables** (2 tables)
   - **Customer Table (`18`)**
   - **Item Table (`27`)**

### 2. **Sales Order Tables** (2 tables)
   - **Sales Header Table (`36`)**
   - **Sales Line Table (`37`)**

### 3. **Transaction/Posting Tables** (6 tables)
   - **Sales Shipment Header Table (`110`)**
   - **Sales Shipment Line Table (`111`)**
   - **Sales Invoice Header Table (`112`)**
   - **Sales Invoice Line Table (`113`)**
   - **Sales Cr. Memo Header Table (`114`)**
   - **Sales Cr. Memo Line Table (`115`)**

### 4. **Ledger and History Tables** (3 tables)
   - **Customer Ledger Entry Table (`21`)**
   - **Item Ledger Entry Table (`32`)**
   - **Value Entry Table (`5802`)**

### 5. **Auxiliary and Lookup Tables** (4+ tables)
   - **Sales Order Archive Header Table (`5107`)**
   - **Sales Order Archive Line Table (`5108`)**
   - **Dimensions and Dimension Entries Tables (`355`, `356`, etc.)** (More dimension tables can be used depending on configuration)

### Total Core Tables: **17+**

There are at least **17 core tables** directly involved in the sales order creation, processing, and posting cycle. The actual number can increase depending on configuration settings such as dimensions, custom extensions, or additional tracking mechanisms.
