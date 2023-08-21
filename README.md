# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## ユーザー情報テーブル（Usersテーブル）

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password_digest|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|

### Association
- has_many :items
- has_many :purchase_records

## 商品情報テーブル（Itemsテーブル）

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|name|string|null: false|
|description|text|null: false|
|category|string|null: false|
|condition|string|null: false|
|shipping_fee|string|null: false|
|shipping_area|string|null: false|
|days_until_shipping|string|null: false|
|price|integer|null: false|

### Association
- belongs_to :user
- has_one :purchase_record

## 購入記録テーブル（PurchaseRecordsテーブル）

|Column|Type|Options|
|------|----|-------|
|buyer_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user, foreign_key: :buyer_id
- belongs_to :item

## 発送先情報テーブル（ShippingAddressesテーブル）

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street_address|string|null: false|
|building_name|string||
|phone_number|string|null: false|

### Association
- belongs_to :user
