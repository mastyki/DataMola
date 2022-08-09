import csv

header = ['product_id', 'product_name', 'product_desc', 'category_id', 'category_name', 'category_desc', 'subcategory_id', 'subcategory_name', 'subcategory_desc']
burgers_products = ['CHEESEBURGER','DOUBLE CHICKEN BURGER','CHICKENBURGER','CHEFBURGER', 'SANDERSBURGER']
chicken_products = ['STRIPS','DRUMSTICK','BITES','NUGGETS']
snacks_products = ['FRENCH FRIES','HOMEMADE POTATOES','HASH BROWN']
buckets_products = ['BUCKET 8 DRUMSTIKS','BUCKET DUET','BUCKET', 'BUCKET BITES']
deserts_products = ['ICE-CREAM SUMMER FANTASY','SUMMER ICE-CREAM','DONUT', 'MUFFIN']
food_subcategories = [burgers_products, chicken_products, snacks_products, buckets_products, deserts_products]

cold_drinks_products = ['PEPSI', 'JUICE', 'WATER', 'COCA-COLA', 'FANTA', 'SCHWEPPES', 'ALIVARIA', 'MILKSHAKE']
hot_drinks_products = ['COFFEE', 'TEA']
drinks_subcategories = [cold_drinks_products,hot_drinks_products]
categories = [food_subcategories,drinks_subcategories]

categories_names = ['FOOD', 'DRINKS']
subcategories_food_names = ['BURGERS', 'CHICKEN', 'SNACKS', 'BUCKETS', 'DESERTS']
subcategories_drinks_names = ['COLD DRINKS', 'HOT DRINKS']
names = [subcategories_food_names,subcategories_drinks_names]

with open('products.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC)
    writer.writerow(header)
    category_cnt = 1
    product_cnt = 1
    product_name_cnt = 0
    for category in categories:
        subcategory_cnt = 1
        category_name = categories_names[category_cnt-1]
        for subcategory in category:
            subcategory_name = names[product_name_cnt][subcategory_cnt - 1]

            for product in subcategory:
                row = f'"{product_cnt}" '
                data = [product_cnt,product,f'{product} DESCRIPTION', category_cnt,category_name, f'{category_name} CATEGORY DESCRIPTION', category_cnt,category_name, f'{category_name} SUBCATEGORY DESCRIPTION' ]
                product_cnt += 1
                writer.writerow(data)

            subcategory_cnt += 1
        category_cnt += 1
        product_name_cnt += 1

#,{{product}DESCRIPTION",{category_cnt},"{category_name}","{category_name} CATEGORY DESCRIPTION",{subcategory_cnt},"{subcategory_name}","{subcategory_name} SUBCATEGORY DESCRIPTION"