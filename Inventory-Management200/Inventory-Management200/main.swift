import Foundation

// Prices
let cerealPrice: Double = 4.99
let milkPrice: Double = 4.99
let syrupPrice: Double = 3.99
let cupPrice: Double = 2.99

// Initial Quantities in stock
var cerealsStock = 100
var milksStock = 100
var syrupsStock = 100
var cupsStock = 100

// User's Cart Items
var cart: [String: Int] = ["Cereals": 0, "Milks": 0, "Syrups": 0, "Cups": 0]

// Function to get the item name based on number selection
func getItemName(_ selection: Int) -> String {
    if selection == 1 {
        return "Cereals"
    } else if selection == 2 {
        return "Milks"
    } else if selection == 3 {
        return "Syrups"
    } else if selection == 4 {
        return "Cups"
    } else {
        return ""
    }
}

// Function to check if the requested quantity is available in stock
func checkStock(_ item: Int, _ quantity: Int) -> Int {
    if item == 1 {
        return min(quantity, cerealsStock)
    } else if item == 2 {
        return min(quantity, milksStock)
    } else if item == 3 {
        return min(quantity, syrupsStock)
    } else if item == 4 {
        return min(quantity, cupsStock)
    } else {
        return 0
    }
}

// Function to display the main menu
func displayMainMenu() {
    print("""
    Welcome to the grocery store! Let us know how we can help you (Enter the number of selection):
    1. Add item to cart
    2. Remove item from cart
    3. Check item availability in stock
    4. Admin Menu
    5. Checkout
    """)
}

// Function to handle adding items to the cart
func addItemToCart() {
    print("What would you like to add to the cart? (Enter the number of selection)")
    print("1. Cereal\n2. Milk\n3. Syrup\n4. Cups")
    
    if let selection = readLine(), let item = Int(selection), item >= 1 && item <= 4 {
        print("How many \(getItemName(item)) would you like to add to your cart?")
        
        if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
            let availableStock = checkStock(item, quantity)
            if availableStock > 0 {
                cart[getItemName(item)]! += availableStock
                print("You have added \(availableStock) \(getItemName(item)) to your cart!")
                print("Current total is: $\(calculateTotal())")
            } else {
                print("Sorry, insufficient stock!")
            }
        } else {
            print("Invalid quantity. Please enter a valid number.")
        }
    } else {
        print("Invalid selection. Please enter a valid number.")
    }
}

// Function to handle removing items from the cart
func removeItemFromCart() {
    print("What would you like to remove from the cart? (Enter the number of selection)")
    print("1. Cereal\n2. Milk\n3. Syrup\n4. Cups")
    
    if let selection = readLine(), let item = Int(selection), item >= 1 && item <= 4 {
        print("How many \(getItemName(item)) would you like to remove from your cart?")
        
        if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
            if quantity <= cart[getItemName(item)]! {
                cart[getItemName(item)]! -= quantity
                print("Removed \(quantity) from the cart!")
                print("Current total is: $\(calculateTotal())")
            } else {
                print("Invalid quantity. You cannot remove more items than you have in your cart.")
            }
        } else {
            print("Invalid quantity. Please enter a valid number.")
        }
    } else {
        print("Invalid selection. Please enter a valid number.")
    }
}

// Function to check item availability in stock
func checkItemAvailability() {
    print("What item would you like to check if it's in stock? (Enter the number of selection)")
    print("1. Cereal\n2. Milk\n3. Syrup\n4. Cups")
    
    if let selection = readLine(), let item = Int(selection), item >= 1 && item <= 4 {
        let availableStock = checkStock(item, 0)
        print("There are currently \(availableStock) \(getItemName(item)) in stock!")
    } else {
        print("Invalid selection. Please enter a valid number.")
    }
}

// Function to display admin menu
func displayAdminMenu() {
    print("Enter Admin ID:")
    if let adminID = readLine(), adminID == "defADD" {
        print("""
        Welcome to the Admin menu! Let us know how we can help you (Enter the number of selection):
        1. Restock inventory
        2. Generate report
        3. Check number of items
        4. Quit admin menu
        """)
    } else {
        print("Invalid Admin ID. Returning to the main menu.")
        displayMainMenu()
    }
}

// Function to restock inventory (Admin only)
func restockInventory() {
    print("What would you like to restock? (Enter the number of selection)")
    print("1. Cereal\n2. Milk\n3. Syrup\n4. Cups")
    
    if let selection = readLine(), let item = Int(selection), item >= 1 && item <= 4 {
        print("How many units of \(getItemName(item)) would you like to restock?")
        
        if let quantityStr = readLine(), let quantity = Int(quantityStr), quantity > 0 {
            if item == 1 {
                cerealsStock += quantity
            } else if item == 2 {
                milksStock += quantity
            } else if item == 3 {
                syrupsStock += quantity
            } else if item == 4 {
                cupsStock += quantity
            }
            print("Restocked \(quantity) units of \(getItemName(item))")
        } else {
            print("Invalid quantity. Please enter a valid number.")
        }
    } else {
        print("Invalid selection. Please enter a valid number.")
    }
}

// Function to generate report
func generateReport() {
    print("""
    Summary Report:
    Remaining cereals: \(cerealsStock) items
    Remaining milks: \(milksStock) items
    Remaining syrups: \(syrupsStock) items
    Remaining cups: \(cupsStock) items
    Remaining Inventory: \(calculateTotalStock()) items
    Total Sales: $\(calculateTotalSales())
    """)
}

// Function to check the number of items
func checkNumberOfItems() {
    print("What item would you like to check if it's in stock? (Enter the number of selection)")
    print("1. Cereal\n2. Milk\n3. Syrup\n4. Cups")
    
    if let selection = readLine(), let item = Int(selection), item >= 1 && item <= 4 {
        let availableStock = checkStock(item, 0)
        print("There are currently \(availableStock) \(getItemName(item)) in stock!")
    } else {
        print("Invalid selection. Please enter a valid number.")
    }
}

// Function to calculate the total in the cart
func calculateTotal() -> Double {
    var total: Double = 0.0
    for (item, quantity) in cart {
        if item == "Cereals" {
            total += Double(quantity) * cerealPrice
        } else if item == "Milks" {
            total += Double(quantity) * milkPrice
        } else if item == "Syrups" {
            total += Double(quantity) * syrupPrice
        } else if item == "Cups" {
            total += Double(quantity) * cupPrice
        }
    }
    return total
}

// Function to calculate the total stock
func calculateTotalStock() -> Int {
    return cerealsStock + milksStock + syrupsStock + cupsStock
}

// Function to calculate the total sales
func calculateTotalSales() -> Double {
    return calculateTotal()
}

// Function to handle checkout
func checkout() {
    print("Thanks for shopping with us!")
    print("You purchased the following:")
    for (item, quantity) in cart {
        print("\(item): \(quantity)")
    }
    
    let grandTotal = calculateTotal() * 1.0925
    print(String(format: "Your grand total including tax (9.25%) is: $%.2f", grandTotal))
    
    print("_________________________________________________________________________________________________________")
    
    // Reset the cart
    cart = ["Cereals": 0, "Milks": 0, "Syrups": 0, "Cups": 0]
}

// Main program
func main() {
    while true {
        displayMainMenu()
        
        if let choice = readLine(), let option = Int(choice) {
            if option == 1 {
                addItemToCart()
            } else if option == 2 {
                removeItemFromCart()
            } else if option == 3 {
                checkItemAvailability()
            } else if option == 4 {
                displayAdminMenu()
            } else if option == 5 {
                checkout()
            } else {
                print("Please choose an appropriate option!")
            }
        } else {
            print("Please choose an appropriate option!")
        }
    }
}

// Run the main program
main()

