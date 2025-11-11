extends Node

#Note 1: This code can only function on Android.
#Note 2: The purchase overlay will only show if you uploaded the app on Google Play, at least internaly.
# function to buy products: buy(product_id, purchase_type)

@export_category("Products")
@export_multiline var product_ids = "product1,product2"

var payment
var recent_product_id
var recent_purchase_type
var purchased_products_ids = []

signal loaded_products()
signal bought_product(product_id: String)

func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"): # Testing if you enabled the plugin
		payment = Engine.get_singleton("GodotGooglePlayBilling") # Adds the payment system to the variable
		
		payment.connected.connect(_on_connected) # Fired when sucessfully connected
		payment.connect_error.connect(_on_connect_error) # Fired when failed to connect, RETURNS: Error ID (int), Error Message (string)
		payment.sku_details_query_completed.connect(_on_product_details_query_completed) # Fired when successfully prepared the products for possible purchases, RETURNS: Products (Dictionary[])
		payment.sku_details_query_error.connect(_on_product_details_query_error) # Fired when failed to prepare the products for possible purchases, RETURNS: Error ID (int), Error Message (string), Product Token (string[])
		payment.purchases_updated.connect(_on_purchases_updated) # Fired when successfully purchased, RETURNS: Purchases (Dictionary[])
		payment.purchase_error.connect(_on_purchase_error) # Fired when failed to purchase, RETURNS: Error ID (int), Error Message (string)
		payment.purchase_consumed.connect(_on_purchase_consumed) # Fired when successfully consumed the purchase, RETURNS: Purchase Token (string)
		payment.purchase_consumption_error.connect(_on_purchase_consumption_error) # Fired when failed to consume the purchase, RETURNS: Error ID (int), Error Message (string), Purchase Token (string)
		payment.purchase_acknowledged.connect(_on_purchase_acknowledged) # Fired when Google successfully acknowledged the purchase, RETURNS: Purchase Token (string)
		payment.purchase_acknowledgement_error.connect(_on_purchase_acknowledgement_error) # Fired when Google failed to acknowledge the purchase, RETURNS: Error ID (int), Error Message (string), Purchase Token (string)
		payment.query_purchases_response.connect(_on_query_purchases_response) # Returns the Purchases (Dictionary[])
		
		payment.startConnection() # This tries to connect

func _on_connected():
	print("Successfully connected")
	payment.querySkuDetails(product_ids.split(","), "inapp") # This prepares the products for possible purchases
	payment.queryPurchases("inapp") # This gets all the purchases that you have done (if any)

func _on_connect_error(_errorid, _errormessage):
	print("Failed to connect")

func _on_product_details_query_completed(_products):
	print("Successfully prepared the products")
	emit_signal("loaded_products")
	
	# Attemps to restore purchases
	payment.queryPurchases("inapp") # Or "subs" for subscriptions

func _on_product_details_query_error(_errorid, _errormessage, _producttoken):
	print("Failed to prepare the product")

#BUY FUNCTION
func buy(product_id, purchase_type):
	recent_product_id = product_id
	recent_purchase_type = purchase_type
	payment.purchase(product_id) # This purchases the item
###

func _on_purchases_updated(purchases):
	if recent_purchase_type == "consumable":
		if purchases.size() > 0:
			# This consumes the purchase by getting the recent purchase's token
			payment.consumePurchase(purchases[purchases.size() - 1].purchase_token)
			
	elif recent_purchase_type == "one-time":
		for purchase in purchases: # This goes over all purchases
			if not purchase.is_acknowledged:
				payment.acknowledgePurchase(purchase.purchase_token) # This acknowledges the purchase
				
	emit_signal("bought_product", recent_product_id)
	print("Successfully purchased")

func _on_purchase_error(_errorid, _errormessage):
	print("Failed to purchase")

#CONSUMABLE
func _on_purchase_consumed(_purchasetoken):
	print("Successfully consumed the purchase")

func _on_purchase_consumption_error(_errorid, _errormessage, _purchasetoken):
	print("Failed to consume the purchase")

#ONE-TIME
func _on_purchase_acknowledged(_purchasetoken):
	print("Successfully acknowledged the purchase")

func _on_purchase_acknowledgement_error(_errorid, _errormessage, _purchasetoken):
	print("Failed to acknowledge the purchase")

#RESTORE PURCHASES
func _on_query_purchases_response(query_result):
	if query_result.status == OK:
		for purchase in query_result.purchases:
			if not purchase.sku in purchased_products_ids:
				purchased_products_ids.append(purchase.sku)
	else:
		print("Failed to restore purchases.")

func bought(product_id: String) -> bool:
	return product_id in purchased_products_ids
