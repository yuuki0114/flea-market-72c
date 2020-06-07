## Addressesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_code|string|null: false|
|prefectures|string|null: false|
|municipalities|string|null: false|
|street_number|string|null: false|
|detail_building|string|
|telephone_number|string|
|user_id|references|null: false, foreign_key:true|

### Association
- belongs_to :user


## Profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|image|string|
|introduction|text|
|user_id|references|null: false, foreign_key:true|

### Association
- belongs_to :user


## Credit-cards
|Column|Type|Options|
|------|----|-------|
|card-number|integer|null: false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key:true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user

add_index :credit-cards, :card-number, unique: true


## Usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_one :address
- has_one :profile
- has_one :credit-card
- has_many :items

### Association
- belongs_to :user
- belongs_to :item


## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|status|integer|null: false|
|delivery_fee|string|null: false|
|start_address|string|null: false|
|shipping_date|string|null: false|
|price|integer|null: false|
|brand_id|references|null: false, foreign_key:true|
|category_id|references|null: false, foreign_key:true|

### Association
- belongs_to :category
- belongs_to :brand
- has_many :images
- belongs_to :user

accept_nested_attributes_for :images

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key:true|

### Association
- belongs_to :item


## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|

### Association
- has_many :items


## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index: true|

### Association
- has_many :items


